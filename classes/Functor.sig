signature FunctorI = sig
  type 'a t
  val map : ('a -> 'b) -> 'a t -> 'b t
end

signature FunctorO = sig
  include FunctorI

  val app : ('a -> unit) -> 'a t -> unit
end

signature Functor = sig
  structure Functor : FunctorI
end
