signature Cont =
sig
  type ('a, 'r) t = ('a -> 'r) -> 'r

  val return : 'a -> ('a, 'r) t
  val >>= : ('a, 'r) t * ('a -> ('b, 'r) t) -> ('b, 'r) t

  val callCC : ('a -> 'r, ('a, 'r) t) t
  val throw : ('a -> 'r) -> 'a -> ('b, 'r) t
end
