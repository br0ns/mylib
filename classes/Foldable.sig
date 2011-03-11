signature FoldableCore = sig
  type 'a foldable
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a foldable -> 'b
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a foldable -> 'b
end

signature FoldableBase = FoldableCore

signature Foldable = sig
  include FoldableCore

  val foldr1 : ('a * 'a -> 'a) -> 'a foldable -> 'a option
  val foldl1 : ('a * 'a -> 'a) -> 'a foldable -> 'a option
  val foldrUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
  val foldlUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
  val appl : ('a -> '_) -> 'a foldable -> unit
  val appr : ('a -> '_) -> 'a foldable -> unit
  val applUntil : ('a -> bool) -> 'a foldable -> unit
  val applUntil : ('a -> bool) -> 'a foldable -> unit
  val toList : 'a foldable -> 'a list
  val concatF : 'a list foldable -> 'a list
  val concatL : 'a foldable list -> 'a list
  val concatMap : ('a -> 'b list) -> 'a foldable -> 'b list
  val conjoin : bool foldable -> bool
  val disjoin : bool foldable -> bool
  val any : ('a -> bool) -> 'a foldable -> bool
  val all : ('a -> bool) -> 'a foldable -> bool
  val find : ('a -> bool) -> 'a foldable -> 'a option
  val findr : ('a -> bool) -> 'a foldable -> 'a option
  val findl : ('a -> bool) -> 'a foldable -> 'a option
  val member : ''a -> ''a foldable -> bool
  val notMember : ''a -> ''a foldable -> bool
  val maximumBy : ('a * 'a -> order) -> 'a foldable -> 'a option
  val minimumBy : ('a * 'a -> order) -> 'a foldable -> 'a option
  val intSum : int foldable -> int
  val realSum : real foldable -> real
  val intProduct : int foldable -> int
  val realProduct : real foldable -> real
  val leftmost  : 'a option foldable -> 'a option
  val rightmost : 'a option foldable -> 'a option
end
