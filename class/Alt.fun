functor Alt (A : Alt) : AltEX =
struct (Idiom, Func)
open A
infix || **

fun plus a b = a || b
fun optional xs = (pure SOME ** xs) || pure NONE
fun merger ms = List.foldr op|| (genZero ()) ms
fun mergel ms = List.foldl op|| (genZero ()) ms
fun guard true  = pure ()
  | guard false = genZero ()

end
