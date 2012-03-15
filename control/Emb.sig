signature Emb =
sig
  type ('a, 'b) t = ('a -> 'b) * ('b -> 'a Option.t)

  val id : ('a, 'a) t
  val to : ('a, 'b) t -> 'a -> 'b
  val from : ('a, 'b) t -> 'b -> 'a Option.t
  val <--> : ('b, 'c) t * ('a, 'b) t -> ('a, 'c) t
end
