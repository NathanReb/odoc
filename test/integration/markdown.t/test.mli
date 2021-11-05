(** {1 This is a heading }*)

(** {2:label This has a label}*)

type y'
module X : sig

  (** doc for x *)
    type x 
  module type Y = sig
    type y = y'
  end
end

type name = {fname : string; (** first name *) lname: string}

(** {2:foo Label} *)

(** {{:href} test_two } *)

(** {{:href} {b test}} *)

(** {{:href} test two foo } *)

(** {{:href} {foo_bar} } *)
(** {{:href} **barz** } *)

(** {v
verbatim
text
v} *)

(** See if listness is preserved. *)

(** This is an {i interface} with {b all} of the {e module system} features.
    This documentation demonstrates:
- comment formatting
- unassociated comments
- documentation sections
- module system documentation including
 {ol
 {- submodules}
 {- module aliases}
 {- module types}
 {- module type aliases}
 {- modules with signatures}
 {- modules with aliased signatures}
}

A numbered list:
+ 3
+ 2
+ 1

    David Sheets is the author.
    @author David Sheets
*)


(** The end foo end keyword in doc comment. *)
module Foo : sig
  type foo
  type poly = [ `Mon | `Tue ]
  type name = { fname:string; lname: string }
end

(** p1 *)

(** p2

   p3

   {ul
     {- a}
     {- b}
    } *)

(** This is where I begin my thing from. *)
(** {ol
      {- one}
      {- two}
    } *)

(** {ul
      {- Mon}
      {- Tue}
    } *)
