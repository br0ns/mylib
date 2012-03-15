signature UnOp =
sig
  type 'a t = 'a -> 'a

  val lift : ('a, 'b) iso -> 'b t -> 'a t
end
