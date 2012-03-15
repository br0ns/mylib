signature Cmp =
sig
  type 'a t = 'a * 'a -> order

  val map : ('b -> 'a) -> 'a t -> 'b t
end
