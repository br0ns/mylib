functor Alternative
        (X : Alternative
        ) :>
        AlternativeO where type 'a t = 'a X.Alternative.t
=
struct
structure Y = ApplicativeEtAl (X)
open Y X.Alternative infix $$ ||

fun optional xs = (SOME $$ xs) || return NONE
fun merge ms = List.foldr op|| zero ms
fun guard true  = return ()
  | guard false = zero

end
