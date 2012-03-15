functor MonoErrorT (I :
                    sig
                      include Monad
                      type error
                      val noMsg  : error
                    end) :>
        MonadMonoError
          where type 'a inner = 'a I.t
            and type    error = I.error
= struct (MonadP)
open ErrorT(I)

open (noMsg) I
fun genZero _ = throw noMsg

type error = I.error
type 'a t = (error, 'a) Either.t inner
end
