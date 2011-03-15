signature Exit = sig
  type 'a t

  val block : ('a t -> 'a) -> 'a
  val <- : 'a t * 'a -> '_
end
