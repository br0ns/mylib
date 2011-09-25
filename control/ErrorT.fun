functor ErrorT (X :
                sig
                  include Monad
                  type error
                  val noMsg : error
                  val strMsg : string -> error
                end) :
        MonadError where type 'a inner = 'a X.monad
                     and type error = X.error =
struct
type error = X.error
type 'a inner = 'a X.monad
type 'a monad = (error, 'a) either inner
type 'a alt = 'a monad

datatype either = datatype Either.t

fun liftM m = X.>>= (m, fn a => X.return $ Right a)

fun throw e = X.return $ Left e
fun (m catch h) = X.>>= (m, fn Left e  => (h e handle Bind => X.return $ Left e)
                             | Right a => X.return $ Right a
                        )

fun run m = m
fun mapError f m = f m

structure M = MonadP(
type 'a pointed = 'a monad
fun return a = X.return $ Right a
type 'a alt = 'a monad
fun m || n = X.>>= (m, fn Left _  => n
                        | Right a => X.return $ Right a)

fun genZero () = throw X.noMsg
type 'a monad = 'a monad
fun m >>= k = X.>>= (m, fn Left e  => X.return $ Left e
                         | Right a => k a
                    )
              )

open M
end
