signature FoldableCore = sig
  type 'a foldable
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a foldable -> 'b
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a foldable -> 'b
end

signature FoldableBase = FoldableCore

signature Foldable = sig
  include FoldableCore

  val foldr1 : 'a binop -> 'a foldable -> 'a option
  val foldl1 : 'a binop -> 'a foldable -> 'a option
  val foldrUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
  val foldlUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
  val appl : 'a effect -> 'a foldable effect
  val appr : 'a effect -> 'a foldable effect
  val applUntil : ('a -> bool) -> 'a foldable effect
  val apprUntil : ('a -> bool) -> 'a foldable effect
  val concat : 'a list foldable -> 'a list
  val concatList : 'a foldable list -> 'a list
  val concatMap : ('a -> 'b list) -> 'a foldable -> 'b list
  val conjoin : bool foldable unpred
  val disjoin : bool foldable unpred
  val any : 'a unpred -> 'a foldable unpred
  val all : 'a unpred -> 'a foldable unpred
  val find : 'a unpred -> 'a foldable -> 'a option
  val findr : 'a unpred -> 'a foldable -> 'a option
  val findl : 'a unpred -> 'a foldable -> 'a option
  val member : ''a -> ''a foldable unpred
  val notMember : ''a -> ''a foldable unpred
  val maximumBy : 'a cmp -> 'a foldable -> 'a option
  val minimumBy : 'a cmp -> 'a foldable -> 'a option
  val intSum : int foldable -> int
  val realSum : real foldable -> real
  val intProduct : int foldable -> int
  val realProduct : real foldable -> real
  val leftmost  : 'a option foldable -> 'a option
  val rightmost : 'a option foldable -> 'a option
end
