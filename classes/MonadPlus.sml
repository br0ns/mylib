functor MonadPlus
          (include MonadPlus
          ) :>
        MonadPlusO where type 'a t = 'a Monad.t
=
struct
type 'a t = 'a Monad.t
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
