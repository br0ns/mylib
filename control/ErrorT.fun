functor ErrorT (I : Monad) :>
        MonadError
          where type 'a inner = 'a I.t =
struct
type 'a inner = 'a I.t
type ('a, 'e) t = ('e, 'a) Either.t inner
datatype either = datatype Either.t

fun op >>= (m, k) =
    do with I
     ; ex <- m
     ; case ex of
         LEFT e  => return (LEFT e)
       | RIGHT x => k x
    end

fun return x = I.return $ RIGHT x

fun op || (a, b) =
    do with I
     ; ex <- a
     ; case ex of
         LEFT e  => b
       | RIGHT x => return $ RIGHT x
    end

fun lift m = I.>>= (m, return)

fun throw e = I.return $ LEFT e

fun op catch (m, h) =
    do with I
     ; x <- m
     ; case x of
         LEFT e  => (h e handle Bind => throw e)
       | RIGHT x => return $ RIGHT x
    end

fun run m = m

fun mapError f m = f m
end
