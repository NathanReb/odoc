open Odoc_document
open Types
open Doctree

module Markup : sig
  (** The goal of this module is to allow to describe a markdown document and
      to print it.
      A markdown document is composed of [blocks]. *)

  type inlines
  (** Inlines elements are rendered one after the other, separated by spaces,
      but not by empty line. *)

  val ( ++ ) : inlines -> inlines -> inlines
  (** Combine inlines. *)

  val join : inlines -> inlines -> inlines

  type blocks
  (** A block is composed of [inlines]. Blocks are separated by an empty line. *)

  val joinB : blocks -> blocks -> blocks

  val ordered_list : blocks list -> blocks

  val unordered_list : blocks list -> blocks

  val blocks : blocks -> blocks -> blocks
  (** Combine blocks. *)

  val block_separator : blocks
  (** A horizontal line between a heading and the body. *)

  val text : string -> inlines
  (** Some inline elements *)

  val line_break : inlines

  (* val nbsp : inlines *)

  val bold : inlines -> inlines

  val italic : inlines -> inlines

  val superscript : inlines -> inlines

  val subscript : inlines -> inlines

  val link : href:string -> inlines -> inlines
  (** Arbitrary link. *)

  val anchor' : string -> inlines

  val raw_markup : string -> blocks

  (* val code_span : string -> inlines *)

  val paragraph : inlines -> blocks

  val code_block : string -> blocks

  val heading : int -> inlines -> blocks

  val noopI : inlines

  val noopB : blocks

  (* val pp_inlines : Format.formatter -> inlines -> unit *)

  val pp_blocks : Format.formatter -> blocks -> unit
  (** Renders a markdown document. *)
end = struct
  (* What we need in the markdown generator:
     Special syntaxes:
     - Pandoc's heading attributes
  *)

  type inlines =
    | String of string
    | ConcatI of inlines * inlines
    | Join of inlines * inlines
        (** [Join] constructor is for joining [inlines] without spaces between them. *)
    | Link of string * inlines
    | Anchor of string
    | Linebreak
    (* | Nbsp *)
    | NoopI

  and blocks =
    | ConcatB of blocks * blocks
    | Block of inlines
    | CodeBlock of string
    | List of list_type * blocks list
    | Raw_markup of string
    | Block_separator
    | NoopB
    | JoinB of blocks * blocks

  and list_type = Ordered | Unordered

  let ordered_list bs = List (Ordered, bs)

  let unordered_list bs = List (Unordered, bs)

  let noopI = NoopI

  let noopB = NoopB

  let ( ++ ) left right = ConcatI (left, right)

  let join left right = Join (left, right)

  let joinB left right = JoinB (left, right)

  (*TODO: Can we find a better name for this, like it is for combining inlines? *)
  let blocks above below = ConcatB (above, below)

  let block_separator = Block_separator

  let text s = String s

  let line_break = Linebreak

  (* let nbsp = Nbsp *)

  let bold i = Join (String "**", Join (i, String "**"))

  let italic i = Join (String "_", Join (i, String "_"))

  let subscript i = Join (String "<sub>", Join (i, String "</sub>"))

  let superscript i = Join (String "<sup>", Join (i, String "</sup>"))

  (* let code_span s =
     if String.contains s '`' then
       Join (String "``", Join (String s, String "``"))
     else Join (String "`", Join (String s, String "`")) *)

  let link ~href i = Link (href, i)

  let anchor' i = Anchor i

  let raw_markup s = Raw_markup s

  let paragraph i = Block i

  let code_block s = CodeBlock s

  let make_hashes n = String.make n '#'

  let heading level i =
    let hashes = make_hashes level in
    Block (String hashes ++ i)

  let pp_list_item fmt list_type (b : blocks) n pp_blocks =
    match list_type with
    | Unordered -> Format.fprintf fmt "- @[%a@]" pp_blocks b
    | Ordered -> Format.fprintf fmt "%d. @[%a@]" (n + 1) pp_blocks b

  let rec pp_inlines fmt i =
    match i with
    | String s -> Format.fprintf fmt "%s" s
    | ConcatI (left, right) ->
        Format.fprintf fmt "%a %a" pp_inlines left pp_inlines right
    | Join (left, right) ->
        Format.fprintf fmt "%a%a" pp_inlines left pp_inlines right
    | Link (href, i) -> Format.fprintf fmt "[%a](%s)" pp_inlines i href
    | Anchor s -> Format.fprintf fmt "<a id=\"%s\"></a>" s
    | Linebreak -> Format.fprintf fmt "@\n"
    (* | Nbsp -> Format.fprintf fmt "\u{00A0}" *)
    | NoopI -> ()

  let rec pp_blocks fmt b =
    match b with
    | ConcatB (above, below) ->
        Format.fprintf fmt "%a@\n@\n%a" pp_blocks above pp_blocks below
    | Block i -> pp_inlines fmt i
    | CodeBlock s -> Format.fprintf fmt "```@\n%s@\n```" s
    | Block_separator -> Format.fprintf fmt "---"
    | List (list_type, l) ->
        let rec pp_list n l =
          match l with
          | [] -> ()
          | [ x ] -> pp_list_item fmt list_type x n pp_blocks
          | x :: rest ->
              pp_list_item fmt list_type x n pp_blocks;
              Format.fprintf fmt "@\n@\n";
              pp_list (n + 1) rest
        in
        pp_list 0 l
    | Raw_markup s -> Format.fprintf fmt "%s" s
    | NoopB -> ()
    | JoinB (above, below) ->
        Format.fprintf fmt "%a%a" pp_blocks above pp_blocks below
end

open Markup

(* let entity e =
   match e with "#45" -> escaped "-" | "gt" -> str ">" | s -> str "&%s;" s *)

let style (style : style) i =
  match style with
  | `Bold -> bold i
  | `Italic | `Emphasis -> italic i
  | `Superscript -> superscript i
  | `Subscript -> subscript i

let make_hashes n = String.make n '#'

type args = { generate_links : bool }

(*TODO: perhaps the return value of this should be blocks *)
let rec source_code (s : Source.t) args =
  match s with
  | [] -> noopI
  | h :: t -> (
      let continue s = if s = [] then noopI else source_code s args in
      match h with
      | Source.Elt i -> inline i args ++ continue t
      | Tag (None, s) -> continue s ++ continue t
      | Tag (Some _, s) -> continue s ++ continue t)

and inline (l : Inline.t) args =
  match l with
  | [] -> noopI
  | i :: rest -> (
      let continue i = if i = [] then noopI else inline i args in
      let cond then_clause else_clause =
        if args.generate_links then then_clause else else_clause
      in
      match i.desc with
      | Text "" -> continue rest
      | Text s -> (
          match s with
          | "end" (* TODO: | "}" | "]"  *) ->
              noopI
              (* string (make_hashes 6) ++ space ++  ++ string s *)
              (*TODO: This should surely be handle right! *)
          | _ ->
              let l, _, rest =
                Doctree.Take.until l ~classify:(function
                  | { Inline.desc = Text s; _ } -> Accum [ text s ]
                  | _ -> Stop_and_keep)
              in
              let rec inline' l' =
                match l' with
                | [] -> noopI
                | [ i ] -> i
                | i :: rest -> i ++ inline' rest
              in
              inline' l ++ continue rest)
      | Entity _ -> noopI
      | Styled (sty, content) -> style sty (continue content) ++ continue rest
      | Linebreak -> line_break ++ continue rest
      | Link (href, content) ->
          link ~href (inline content args) ++ continue rest
      | InternalLink (Resolved (link, content)) ->
          cond
            (match link.page.parent with
            | Some _ -> continue content ++ continue rest
            | None ->
                noopI
                (*TODO: This needs to be handled right! *)
                (* make_link content (make_hashes 1 ^ link.anchor) *))
            (continue content ++ continue rest)
      | InternalLink (Unresolved content) -> continue content ++ continue rest
      | Source content ->
          cond
            (source_code content args ++ continue rest)
            (source_code content args ++ continue rest)
      | Raw_markup _ -> noopI ++ continue rest)

let rec blocks' (bs : blocks list) =
  match bs with
  | [] -> noopB
  | [ b ] -> b
  | b :: rest -> blocks b (blocks' rest)

let rec block (l : Block.t) args =
  match l with
  | [] -> noopB
  | b :: rest -> (
      let continue r = if r = [] then noopB else block r args in
      match b.desc with
      | Inline i -> blocks (paragraph (inline i args)) (continue rest)
      | Paragraph i -> blocks (paragraph (inline i args)) (continue rest)
      | List (list_typ, l) ->
          let f b =
            match list_typ with
            | Unordered -> unordered_list b
            | Ordered -> ordered_list b
          in
          blocks (f (List.map (fun b -> block b args) l)) (continue rest)
      | Description _ ->
          let descrs, _, rest =
            Take.until l ~classify:(function
              | { Block.desc = Description l; _ } -> Accum l
              | _ -> Stop_and_keep)
          in
          let f i =
            let key = inline i.Description.key args in
            let def = block i.Description.definition args in
            blocks (paragraph (join (join (text "@") key) (text " : "))) def
          in
          blocks (blocks' (List.map f descrs)) (continue rest)
      | Source content ->
          blocks (paragraph (source_code content args)) (continue rest)
      | Verbatim content -> blocks (code_block content) (continue rest)
      | Raw_markup (_, s) -> blocks (raw_markup s) (continue rest))

let heading { Heading.label; level; title } args =
  let title = inline title args in
  match label with
  | Some _ -> (
      match level with
      | 1 -> heading level title
      | _ -> blocks (heading level title) block_separator)
  | None -> noopB
(*TODO: Not sure of what to do here! *)

let inline_subpage = function
  | `Inline | `Open | `Default -> true
  | `Closed -> false

let item_prop = text (make_hashes 6)

let rec documented_src (l : DocumentedSrc.t) args =
  match l with
  | [] -> noopB
  | line :: rest -> (
      let continue r = if r = [] then noopB else documented_src r args in
      match line with
      | Code c -> joinB (paragraph (source_code c args)) (continue rest)
      | Alternative alt -> (
          match alt with Expansion e -> documented_src e.expansion args)
      | Subpage p -> joinB (subpage p.content args) (continue rest)
      | Documented _ | Nested _ ->
          let lines, _, rest =
            Take.until l ~classify:(function
              | DocumentedSrc.Documented { code; doc; anchor; _ } ->
                  Accum [ (`D code, doc, anchor) ]
              | DocumentedSrc.Nested { code; doc; anchor; _ } ->
                  Accum [ (`N code, doc, anchor) ]
              | _ -> Stop_and_keep)
          in
          let f (content, doc, (anchor : Odoc_document.Url.t option)) =
            let doc = match doc with [] -> noopB | doc -> block doc args in
            let content =
              match content with
              | `D code -> paragraph (inline code args)
              | `N l -> documented_src l args
            in
            let item = blocks ((joinB (paragraph item_prop) content)) doc in
            if args.generate_links then
              let anchor =
                match anchor with Some a -> a.anchor | None -> ""
              in
              (*TODO: A line break might be needed here!*)
              blocks (paragraph (anchor' anchor)) item
            else blocks (paragraph line_break) item
          in
          joinB (blocks' (List.map f lines)) (continue rest))

and subpage { title = _; header = _; items; url = _ } args =
  let content = items in
  let surround body =
    if content = [] then noopB else body
    (*TODO: Not sure what to do here! *)
  in
  surround (item content args)

and item (l : Item.t list) args =
  match l with
  | [] -> noopB
  | i :: rest -> (
      let continue r = if r = [] then noopB else item r args in
      match i with
      | Text b -> joinB (block b args) (continue rest)
      | Heading h -> joinB (heading h args) (continue rest)
      | Declaration { attr = _; anchor; content; doc } ->
          let decl = documented_src content args in
          let doc = match doc with [] -> noopB | doc -> block doc args in
          let item' = blocks (joinB (paragraph item_prop) decl) doc in
          if args.generate_links then
            let anchor = match anchor with Some x -> x.anchor | None -> "" in
            joinB (blocks (paragraph (anchor' anchor)) item') (continue rest)
          else blocks item' (continue rest)
      | Include
          { attr = _; anchor = _; content = { summary; status; content }; doc }
        ->
          let d =
            if inline_subpage status then item content args
            else
              let s = source_code summary args in
              match doc with
              | [] -> paragraph s
              | doc -> joinB (paragraph s) (block doc args)
          in
          joinB d (continue rest))

let on_sub subp =
  match subp with
  | `Page p -> if Link.should_inline p.Subpage.content.url then Some 1 else None
  | `Include incl -> if inline_subpage incl.Include.status then Some 0 else None

let page { Page.header; items; url; _ } args =
  let header = Shift.compute ~on_sub header in
  let items = Shift.compute ~on_sub items in
  let blocks'' l = List.map (fun s -> paragraph (text s)) l |> blocks' in
  blocks'
    ([ blocks'' (Link.for_printing url) ]
    @ [ blocks (item header args) (item items args) ])

let rec subpage subp (args : args) =
  let p = subp.Subpage.content in
  if Link.should_inline p.url then [] else [ render p args ]

and render (p : Page.t) args =
  let content fmt = Format.fprintf fmt "%a" Markup.pp_blocks (page p args) in
  let children =
    Utils.flatmap ~f:(fun sp -> subpage sp args) (Subpages.compute p)
  in
  let filename = Link.as_filename p.url in
  { Odoc_document.Renderer.filename; content; children }
