signature Iso =
sig
  type ('a, 'b) t = ('a -> 'b) * ('b -> 'a)

  val id : ('a, 'a) t
  val swap : ('a, 'b) t -> ('b, 'a) t
  val to : ('a, 'b) t -> 'a -> 'b
  val from : ('a, 'b) t -> 'b -> 'a
  val map : ('c, 'a) t * ('b, 'd) t -> ('a, 'b) t -> ('c, 'd) t
  val <--> : ('b, 'c) t * ('a, 'b) t -> ('a, 'c) t
end
