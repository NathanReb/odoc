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


(** {{:href} {b test}} *)
