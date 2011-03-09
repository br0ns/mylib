functor MonadTrans
        (include MonadTrans
        ) :>
        MonadTransO where type 'a t = 'a MonadTrans.t
                    where type 'a inner = 'a MonadTrans.inner
=
struct
open MonadTrans
end
