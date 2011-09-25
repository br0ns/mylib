functor StateT (X :
                sig
                  include Monad
                  type state
                end) :
        MonadState where type 'a inner = 'a X.monad
                     and type state = X.state =
struct
type state = X.state
type 'a inner = 'a X.monad
type 'a monad = state -> ('a * state) inner

fun liftM m s = X.>>= (m, fn a => X.return (a, s))

fun get s = X.return (s, s)
fun put s _ = X.return ((), s)
fun modify f s = X.return ((), f s)
fun gets f s = X.return (f s, s)

fun run m s = m s
fun eval m s = X.>>= (m s, fn (a, _) => X.return a)
fun exec m s = X.>>= (m s, fn (_, s) => X.return s)

fun mapState f m s = f $ m s
fun withState f m s = X.>>= (m s, fn (a, s') => X.return (a, f s'))

structure M = Monad(
type 'a pointed = 'a monad
fun return a s = X.return (a, s)
type 'a monad = 'a monad
fun (m >>= k) s = X.>>= (m s, fn (a, s') => k a s')
              )

open M
end
