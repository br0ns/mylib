functor State'
          (type state
          ) :>
        State where type state = state
=
struct
type state = state
type 'a t = state -> 'a * state

structure Pointed = struct
type 'a t = 'a t
fun return x state = (x, state)
end

structure Monad = struct
type 'a t = 'a t
fun >>= (x, f) state =
    let
      val (a, state') = x state
    in
      f a state'
    end
end

structure MonadState = struct
type state = state
type 'a t = 'a t
fun get state = (state, state)
fun set state _ = ((), state)
end

fun run m s = m s
fun eval m s =
    let
      val (a, _) = m s
    in
      a
    end
fun exec m s =
    let
      val (_, s) = m s
    in
      s
    end
fun mapState f m state = f (m state)
fun withState f m state =
    let
      val (a, s) = m state
    in
      (a, f s)
    end
end

functor State (type state)
=
struct
local
  structure S = State'(type state = state)
  structure M = MonadEtAl (S)
in
open S M
end
end
