functor MonadState
          (include MonadState
          ) :>
        MonadStateO where type 'a t = 'a MonadState.t
=
struct
open Pointed Monad MonadState infix >>=

fun modify f = get >>= (fn state => set (f state))
fun gets f = get >>= (fn state => return (f state))
end
