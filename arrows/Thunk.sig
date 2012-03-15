signature Thunk =
sig
  type 'a t = unit -> 'a
  val force : 'a t -> 'a
  val eager : 'a -> 'a t
  val delay : 'a t t -> 'a t
  val memoise : 'a t unop
  val lift : ('a -> 'b) -> 'a t -> 'b t
  val iso : ('a, 'b) iso -> ('a t, 'b t) iso
end
