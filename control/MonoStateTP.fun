functor MonoStateTP (I : sig type state include MonadP end) :>
        MonadMonoStateP
          where type 'a inner = 'a I.t
            and type    state = I.state
= struct (MonadP)
open StateTP(I)

type state = I.state
type 'a t  = state -> ('a * state) inner
end
