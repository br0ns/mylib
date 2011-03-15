signature MonoFoldableCore = sig
  type foldable_elm
  type foldable
  val foldr : (foldable_elm * 'a -> 'a) -> 'a -> foldable -> 'a
  val foldl : (foldable_elm * 'a -> 'a) -> 'a -> foldable -> 'a
end

signature MonoFoldableBase = MonoFoldableCore

signature MonoFoldable = sig
  include MonoFoldableCore

  val foldr1 : foldable_elm binop -> foldable -> foldable_elm option
  val foldl1 : foldable_elm binop -> foldable -> foldable_elm option
  val foldrUntil : (foldable_elm * 'a -> 'a * bool) -> 'a -> foldable -> 'a
  val foldlUntil : (foldable_elm * 'a -> 'a * bool) -> 'a -> foldable -> 'a
  val appl : foldable_elm effect -> foldable effect
  val appr : foldable_elm effect -> foldable effect
  val apprUntil : foldable_elm unpred -> foldable effect
  val applUntil : foldable_elm unpred -> foldable effect
  val toList : foldable -> foldable_elm list
  val concatList : foldable list -> foldable_elm list
  val concatMap : (foldable_elm -> 'a list) -> foldable -> 'a list
  val any : foldable_elm unpred -> foldable unpred
  val all : foldable_elm unpred -> foldable unpred
  val find : foldable_elm unpred -> foldable -> foldable_elm option
  val findr : foldable_elm unpred -> foldable -> foldable_elm option
  val findl : foldable_elm unpred -> foldable -> foldable_elm option
  val maximumBy : foldable_elm cmp -> foldable -> foldable_elm option
  val minimumBy : foldable_elm cmp -> foldable -> foldable_elm option
end
