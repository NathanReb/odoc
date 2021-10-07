(** {1 This is a heading }*)

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

(** {ul
     {- p1

        p2}
    } *)

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
