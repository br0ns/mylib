functor Alt (Al : AltBase) : Alt =
struct
structure Ap = App (Al)
open Ap Al
infix $$ ||

fun plus a b = a || b
fun optional xs = (SOME $$ xs) || return NONE
fun merge ms = List.foldr op|| zero ms
fun guard true  = return ()
  | guard false = zero

end
