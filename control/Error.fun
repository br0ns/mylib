functor Error (type error val noMsg : error) :>
        MonadMonoError where type    error = error
                         and type 'a inner = 'a
= MonoErrorT(type error = error val noMsg = noMsg open Identity)
