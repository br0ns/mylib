functor MonadPlus
          (include MonadPlus
          ) :>
        MonadPlusO where type 'a t = 'a Monad.t
=
struct
open Monad MonadPlus

fun msum ms = List.foldr ++ zero ms
fun guard true  = return ()
  | guard false = zero
end
