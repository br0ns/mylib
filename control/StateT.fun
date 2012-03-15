functor StateT (I : Monad) :>
        MonadState
          where type 'a inner = 'a I.t =
struct
type 'a inner = 'a I.t
type ('a, 's) t  = 's -> ('a * 's) inner

fun op >>= (m, k) s =
    do with I
     ; (a, s') <- m s
     ; k a s'
    end

fun return a s = I.return (a, s)

fun lift m s =
    do with I
     ; a <- m
     ; return (a, s)
    end

fun get s = I.return (s, s)
fun put s _ = I.return ((), s)
fun modify f s = I.return ((), f s)
fun gets f s = I.return (f s, s)

fun eval m s = I.>>= (m s, fn (a, _) => I.return a)
fun exec m s = I.>>= (m s, fn (_, s) => I.return s)

fun mapState f m s = f (m s)
fun withState f m s =
    do with I
     ; (a, s') <- m s
     ; return (a, f s')
    end
end
