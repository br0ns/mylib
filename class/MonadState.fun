functor MonadState (MS : MonadStateBase) : MonadState =
struct
structure M = Monad (MS)
open M MS

fun modify f = get >>= (set o f)
fun gets f = get >>= (return o f)
end
