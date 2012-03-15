functor MonoStateT (I : sig type state include Monad end) :>
        MonadMonoState
          where type 'a inner = 'a I.t
            and type    state = I.state
= struct (Monad)
open StateT(I)

type state = I.state
type 'a t  = state -> ('a * state) inner
end
