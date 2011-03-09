signature FunctorI = sig
  type 'a t
  val map : ('a -> 'b) -> 'a t -> 'b t
end

signature FunctorO = sig
  include FunctorI

  val app : ('a -> '_) -> 'a t -> unit
  val --> : 'a t * ('a -> 'b) -> 'b t
  val $$ : ('a -> 'b) * 'a t -> 'b t
  val lift : ('a -> 'b) -> 'a t -> 'b t
  val $| : 'a * 'b t -> 'a t
end

signature Functor = sig
  structure Functor : FunctorI
end
