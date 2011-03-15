functor MonoMonadP (MP : MonoMonadPBase) : MonoMonadP =
struct
structure M = MonoMonad (MP)
open M MP

fun plus a b = a || b
fun merger ms = List.foldr op|| zero ms
fun mergel ms = List.foldl op|| zero ms

fun mapPartial f m =
    m >>= (fn x => case f x of
                     SOME y => return y
                   | NONE   => zero
          )
end
