signature PolyMonad =
sig
  type ('a, 'x) t
  val >>= : ('a, 'e) t * ('a -> ('b, 'e) t) -> ('b, 'e) t
  val return : 'a -> ('a, 'e) t
end

signature PolyMonadEX =
sig
  type 'a outer
  val polymorphically : a' outer -> ('a, 'x) t
  structure Monad : MonadEX where type 'a t = 'a outer
end

signature PolyMonadP =
sig
  type ('a, 'x) t
  val >>= : ('a, 'e) t * ('a -> ('b, 'e) t) -> ('b, 'e) t
  val return : 'a -> ('a, 'e) t
end

signature PolyMonadEX =
sig
  include PolyMonad
type 'a outer
val polymorphically : a' outer -> ('a, 'x) t
structure Monad : MonadEX where type 'a t = 'a outer
end
