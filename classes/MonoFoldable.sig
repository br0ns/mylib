signature MonoFoldableCore = sig
  type foladble_elm
  type foldable
  val foldr : (foldable_elm * 'a -> 'a) -> 'a -> foldable -> 'a
  val foldl : (foldable_elm * 'a -> 'a) -> 'a -> foldable -> 'a
end

signature MonoFoldableBase = FoldableCore

signature MonoFoldable = sig
  include MonoFoldableCore

  val foldr1 : foldable_elm BinOp.t -> foldable -> foldable_elm option
  val foldl1 : foldable_elm BinOp.t -> foldable -> foldable_elm option
  val foldrUntil : (foldable_elm * 'a -> 'a * bool) -> 'a -> foldable -> 'a
  val foldlUntil : (foldable_elm * 'a -> 'a * bool) -> 'a -> foldable -> 'a
  val appl : (foldable_elm -> '_) -> foldable -> unit
  val appr : (foldable_elm -> '_) -> foldable -> unit
  val applUntil : foldable_elm UnPred.t -> foldable -> unit
  val applUntil : foldable_elm UnPred.t -> foldable -> unit
  val toList : foldable -> foldable_elm list
  val concatL : foldable list -> foldable_elm list
  val concatMap : (foldable_elm -> 'a list) -> foldable -> 'a list
  val any : foldable_elm UnPred.t -> foldable -> bool
  val all : foldable_elm UnPred.t -> foldable -> bool
  val find : foldable_elm UnPred.t -> foldable -> foldable_elm option
  val findr : foldable_elm UnPred.t -> foldable -> foldable_elm option
  val findl : foldable_elm UnPred.t -> foldable -> foldable_elm option
  val maximumBy : (foldable_elm Cmp.t) -> foldable -> foldable_elm option
  val minimumBy : (foldable_elm Cmp.t) -> foldable -> foldable_elm option
end
