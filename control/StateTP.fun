functor StateTP (I : MonadP) :>
        MonadStateP
          where type 'a inner = 'a I.t =
struct
open StateT(I)
fun genZero () s =
    do with I
     ; z <- I.genZero ()
     ; return (z, s)
    end

fun op || (m, n) s = I.|| (m s, n s)
end
