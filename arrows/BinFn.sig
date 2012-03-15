signature BinFn =
sig
  type ('a, 'b) t = 'a * 'a -> 'b

  val lift : ('c -> 'a) * ('b -> 'd) -> ('a, 'b) t -> ('c, 'd) t
end
