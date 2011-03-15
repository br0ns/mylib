functor Alt (Al : AltBase) : Alt =
struct
structure Ap = App (Al)
open Ap Al

fun plus a b = a || b
fun optional xs = (SOME $$ xs) || return NONE
fun merger ms = List.foldr op|| zero ms
fun mergel ms = List.foldl op|| zero ms
fun guard true  = return ()
  | guard false = zero

end
