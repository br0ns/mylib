functor MonadError
          (include MonadError
          ) :>
        MonadErrorO where type 'a t = 'a Monad.t
=
struct
open MonadError
end
