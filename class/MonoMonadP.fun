functor MonoMonadP (MP : MonoMonadP) : MonoMonadPEX =
struct (MonoMonad)
open MP infix ||

fun plus a b = a || b
fun merger ms = List.foldr op|| (genZero ()) ms
fun mergel ms = List.foldl op|| (genZero ()) ms

fun mapPartial f m =
    do x <- m
     ; case f x of
         SOME y => return y
       | NONE   => genZero ()
    end;

fun keep p m =
    do x <- m
     ; if p x then return x else genZero ()
    end

fun reject p = keep (not o p)
end
