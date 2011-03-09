signature FoldableI = sig
  type 'a e
  type 'a t
  val foldl : ('a e * 'b -> 'b) -> 'b -> 'a t -> 'b
end

signature FoldableO = sig
  include FoldableI

  val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
  val foldr1 : ('a * 'a -> 'a) -> 'a t -> 'a option
  val foldl1 : ('a * 'a -> 'a) -> 'a t -> 'a option
  val foldrUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a t -> 'b
  val foldlUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a t -> 'b
  val toList : 'a t -> 'a list
  val concat : 'a list t -> 'a list
  val concatMap : ('a -> 'b list) -> 'a t -> 'b list
  val conjoin : bool t -> bool
  val disjoin : bool t -> bool
  val any : ('a -> bool) -> 'a t -> bool
  val all : ('a -> bool) -> 'a t -> bool
  val find : ('a -> bool) -> 'a t -> 'a option
  val member : ''a -> ''a t -> bool
  val notMember : ''a -> ''a t -> bool
  val maximumBy : ('a * 'a -> order) -> 'a t -> 'a option
  val minimumBy : ('a * 'a -> order) -> 'a t -> 'a option
  val intSum : int t -> int
  val realSum : real t -> real
  val intProduct : int t -> int
  val realProduct : real t -> real
  val leftmost  : 'a option t -> 'a option
  val rightmost : 'a option t -> 'a option
end

signature Foldable = sig
  structure Foldable : FoldableI
end
