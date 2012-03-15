signature BinPred =
sig
  type 'a t = 'a * 'a -> bool

  val lift : ('a -> 'b) -> 'b t -> 'a t
end
