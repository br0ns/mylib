functor StateT' (type state include Monad)
=
struct
structure Inner = struct
type 'a t = 'a Monad.t
val >>= = Monad.>>=
val return = Pointed.return
end

type state = state
type 'a inner = 'a Inner.t
type 'a t = state -> ('a * state) inner

structure Pointed = struct
type 'a t = 'a t
fun return x s = Inner.return (x, s)
end

structure Monad = struct
type 'a t = 'a t
fun >>= (m, f) s =
    Inner.>>= (m s, fn (x, s') => f x s')
end

structure MonadState = struct
type state = state
type 'a t = 'a t
fun get s = Inner.return (s, s)
fun set s _ = Inner.return ((), s)
end

structure MonadTrans = struct
type 'a t = 'a t
type 'a inner = 'a inner
fun liftM i s = Inner.>>= (i, fn x => Inner.return (x, s))
end

fun run m s = m s
fun eval m s =
    Inner.>>= (m s, fn (x, _) => Inner.return x)
fun exec m s =
    Inner.>>= (m s, fn (_, s) => Inner.return s)
fun mapState f m s = f (m s)
fun withState f m s =
    Inner.>>= (m s, fn (x, s') => Inner.return (x, f s'))
end

functor StateTPlus' (M : sig type state include MonadPlus end)
=
struct
open M
local
  structure X = StateT' (M)
in
open X
end

structure Alternative = struct
type 'a t = 'a t
fun zero _ = Alternative.zero
fun || (m, n) s = Alternative.|| (m s, n s)
end
end

functor StateT (M : sig type state include Monad end)
=
struct
local
  structure S :> StateT where type state = M.state
                        where type 'a inner = 'a M.Monad.t
              = StateT' (M)
  structure M = MonadEtAl (S)
in
open S M
end
end

functor StateTPlus (M : sig type state include MonadPlus end)
=
struct
local
  structure S :> StateTPlus where type state = M.state
                            where type 'a inner = 'a M.Monad.t
              = StateTPlus' (M)
  structure M = MonadPlusEtAl (S)
in
open S M
end
end
