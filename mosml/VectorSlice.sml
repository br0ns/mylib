structure VectorSlice :> VECTOR_SLICE =
struct
  type 'a slice = unit
  fun die _ = raise Fail "VectorSlice not implemented under Moscow ML (yet)"
  val length = die
  val sub = die
  val full = die
  val slice = die
  val subslice = die
  val base = die
  val vector = die
  val concat = die
  val isEmpty = die
  val getItem = die
  val appi = die
  val app  = die
  val mapi = die
  val map  = die
  val foldli = die
  val foldri = die
  val foldl  = die
  val foldr  = die
  val findi = die
  val find  = die
  val exists = die
  val all = die
  val collate = die
end
