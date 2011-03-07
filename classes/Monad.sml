functor Monad
          (include Monad
          ) :>
        MonadO where type 'a t = 'a Monad.t
=
struct
open Monad

infix >>= >> =<< >=> <=< ap

fun m >> n = m >>= (fn _ => n)
fun seq ms =
    List.foldr
      (fn (m, m') =>
          m >>= (fn x => m' >>= (fn xs => return (x :: xs)))
      )
      (return nil)
      ms
fun seq' ms = List.foldr op>> (return ()) ms

fun mapM f xs = seq (List.map f xs)
fun mapM' f xs = seq' (List.map f xs)

fun filterM p xs =
    case xs of
      nil     => return nil
    | x :: xs => p x >>= (fn px =>
                 filterM p xs >>= (fn ys =>
                 return (if px then x :: ys else ys)
                 ))

fun m =<< n = n >>= m
fun (f >=> g) x = f x >>= g
fun (f <=< g) x = g x >>= f

fun forever m = m >> forever m
fun foreverWithDelay d m =
    let
      val t = Time.fromMilliseconds (LargeInt.fromInt d)
      fun delay x = (OS.Process.sleep t ; return x)
    in
      forever (m >>= delay)
    end

fun ignore m = m >> return ()

fun join x = x >>= (fn x => x)

fun tabulateM n m =
    seq (List.tabulate (n, fn _ => m))

fun tabulateM' n m =
    seq' (List.tabulate (n, fn _ => m))

fun when p m = if p then m else return ()
fun unless p m = if p then return () else m

fun m ap n = m >>= (fn f => n >>= (fn x => return (f x)))
infix ap
fun liftM f a = return f ap a
fun liftM2 f a b = liftM f a ap b
fun liftM3 f a b c = liftM2 f a b ap c
fun liftM4 f a b c d = liftM3 f a b c ap d
end

functor Monad' (M : MonadI) = Monad (structure Monad = M)

functor ApplicativeFromMonad (M : MonadI) :>
        ApplicativeI where type 'a t = 'a M.t
=
struct
structure M = Monad' (M)
open M infix >>=
val pure = return
val ** = ap
end
