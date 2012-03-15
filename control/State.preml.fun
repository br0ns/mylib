functor State (type state) :> MonoMonadState where type state = state
                                               and type 'a inner = 'a
= MonoStateT(type state = state open Identity)