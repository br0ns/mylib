signature Pair =
sig
  type ('a, 'b) t = 'a * 'b

  val swap : 'a * 'b -> 'b * 'a
  val swizzle : ('a * 'b) * ('c * 'd) -> ('a * 'c) * ('b * 'd)
  val fst : 'a * 'b -> 'a
  val snd : 'a * 'b -> 'b
  val app : ('a -> Unit.t) * ('b -> Unit.t) -> 'a * 'b -> Unit.t
  val appFst : ('a -> Unit.t) -> 'a * 'b -> Unit.t
  val appSnd : ('b -> Unit.t) -> 'a * 'b -> Unit.t
  val map : ('a -> 'c) * ('b -> 'd) -> 'a * 'b -> 'c * 'd
  val mapFst : ('a -> 'c) -> 'a * 'b -> 'c * 'b
  val mapSnd : ('b -> 'c) -> 'a * 'b -> 'a * 'c
  val foldl : ('a * 'c -> 'c) * ('b * 'c -> 'c) -> 'c -> 'a * 'b -> 'c
  val foldr : ('a * 'c -> 'c) * ('b * 'c -> 'c) -> 'c -> 'a * 'b -> 'c
  val delay : 'a Lazy.t * 'b Lazy.t -> ('a * 'b) Lazy.t
end