functor MonadError (ME : MonadErrorBase) : MonadError =
struct
structure M = Monad (ME)
open M ME
end
