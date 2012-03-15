functor MonadP (MP : MonadP) : MonadPEX =
struct (Monad, Alt)
open MP

fun mapPartial f m =
    do x <- m
     ; case f x of
         SOME y => return y
       | NONE   => genZero ()
    end

fun keep p m =
    do x <- m
     ; if p x then return x else genZero ()
    end

fun reject p = keep (not o p)
end
