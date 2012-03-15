functor State (type state) :> MonadMonoState where type state = state
                                               and type 'a inner = 'a
= MonoStateT(type state = state open Identity)
