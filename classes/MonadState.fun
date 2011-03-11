functor MonadState (MS : MonadStateBase) : MonadState =
struct
infix >>=

structure M = Monad (MS)
open M MS

fun modify f = get >>= (fn state => set (f state))
fun gets f = get >>= (fn state => return (f state))
end
