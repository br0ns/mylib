signature FoldableCore = sig
  type 'a foldable
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a foldable -> 'b
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a foldable -> 'b
end

signature FoldableBase = FoldableCore

signature Foldable = sig
  include FoldableCore

  val foldr1 : 'a BinOp.t -> 'a foldable -> 'a option
  val foldl1 : 'a BinOp.t -> 'a foldable -> 'a option
  val foldrUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
  val foldlUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
  val appl : 'a Effect.t -> 'a foldable Effect.t
  val appr : 'a Effect.t -> 'a foldable Effect.t
  val applUntil : ('a -> bool) -> 'a foldable Effect.t
  val toList : 'a foldable -> 'a list
  val concat : 'a list foldable -> 'a list
  val concatList : 'a foldable list -> 'a list
  val concatMap : ('a -> 'b list) -> 'a foldable -> 'b list
  val conjoin : bool foldable UnPred.t
  val disjoin : bool foldable UnPred.t
  val any : 'a UnPred.t -> 'a foldable UnPred.t
  val all : 'a UnPred.t -> 'a foldable UnPred.t
  val find : 'a UnPred.t -> 'a foldable -> 'a option
  val findr : 'a UnPred.t -> 'a foldable -> 'a option
  val findl : 'a UnPred.t -> 'a foldable -> 'a option
  val member : ''a -> ''a foldable UnPred.t
  val notMember : ''a -> ''a foldable UnPred.t
  val maximumBy : 'a Cmp.t -> 'a foldable -> 'a option
  val minimumBy : 'a Cmp.t -> 'a foldable -> 'a option
  val intSum : int foldable -> int
  val realSum : real foldable -> real
  val intProduct : int foldable -> int
  val realProduct : real foldable -> real
  val leftmost  : 'a option foldable -> 'a option
  val rightmost : 'a option foldable -> 'a option
end
