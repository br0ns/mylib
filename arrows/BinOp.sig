signature BinOp =
sig
  type 'a t = 'a * 'a -> 'a

  val lift : ('a, 'b) iso -> 'b t -> 'a t
end
