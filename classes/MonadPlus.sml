functor MonadPlus
          (X : MonadPlus
          ) :>
        MonadPlusO where type 'a t = 'a X.Monad.t
=
struct
structure Y = MonadEtAl (X)
open Y X.Alternative

fun msum ms = List.foldr || zero ms
fun guard true  = return ()
  | guard false = zero
end

functor MonadPlusEtAl (X : MonadPlus) =
struct
local
  structure Y = MonadEtAl (X)
  structure A = Alternative (open X Y)
  structure MP = MonadPlus (X)
in
open Y A MP
end

end
