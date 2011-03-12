signature MonoFoldableCore = sig
  type foldable_elm
  type foldable
  val foldr : (foldable_elm * 'a -> 'a) -> 'a -> foldable -> 'a
  val foldl : (foldable_elm * 'a -> 'a) -> 'a -> foldable -> 'a
end

signature MonoFoldableBase = MonoFoldableCore

signature MonoFoldable = sig
  include MonoFoldableCore

  val foldr1 : foldable_elm BinOp.t -> foldable -> foldable_elm option
  val foldl1 : foldable_elm BinOp.t -> foldable -> foldable_elm option
  val foldrUntil : (foldable_elm * 'a -> 'a * bool) -> 'a -> foldable -> 'a
  val foldlUntil : (foldable_elm * 'a -> 'a * bool) -> 'a -> foldable -> 'a
  val appl : foldable_elm Effect.t -> foldable Effect.t
  val appr : foldable_elm Effect.t -> foldable Effect.t
  val apprUntil : foldable_elm UnPred.t -> foldable Effect.t
  val applUntil : foldable_elm UnPred.t -> foldable Effect.t
  val toList : foldable -> foldable_elm list
  val concatList : foldable list -> foldable_elm list
  val concatMap : (foldable_elm -> 'a list) -> foldable -> 'a list
  val any : foldable_elm UnPred.t -> foldable UnPred.t
  val all : foldable_elm UnPred.t -> foldable UnPred.t
  val find : foldable_elm UnPred.t -> foldable -> foldable_elm option
  val findr : foldable_elm UnPred.t -> foldable -> foldable_elm option
  val findl : foldable_elm UnPred.t -> foldable -> foldable_elm option
  val maximumBy : foldable_elm Cmp.t -> foldable -> foldable_elm option
  val minimumBy : foldable_elm Cmp.t -> foldable -> foldable_elm option
end
