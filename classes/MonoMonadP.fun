functor MonoMonadP (MP : MonoMonadPBase) : MonoMonadP =
struct
structure M = MonoMonad (MP)
open M MP infix ||

fun plus a b = a || b
fun merger ms = List.foldr op|| zero ms
fun mergel ms = List.foldl op|| zero ms
end
