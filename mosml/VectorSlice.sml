structure VectorSlice :> VECTOR_SLICE =
struct
  type 'a slice = 'a vector * int
  fun die _ = raise Fail "VectorSlice not implemented under Moscow ML (yet)"
  fun length (v, i) = Vector.length v - i
  fun sub ((v, i), i') = Vector.sub (v, i + i')
  fun full v = (v, 0)
  val slice = die
  val subslice = die
  val base = die
  val vector = die
  val concat = die
  val isEmpty = die
  fun getItem (v, i) = SOME (Vector.sub (v, i), (v, i + 1)) handle Subscript => NONE
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
