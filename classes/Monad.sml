functor Monad
          (include Monad
          ) :>
        MonadO where type 'a t = 'a Monad.t
=
struct
open Pointed Monad

infix >>= >> =<< << -- >=> <=<

fun m >> n = m >>= (fn _ => n >>= (fn x => return x))
fun m << n = m >>= (fn x => n >>= (fn _ => return x))
fun m -- n = m >>= (fn x => n >>= (fn y => return (x, y)))
fun join x = x >>= (fn x => x)
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

fun mapAndUnzipM f xs =
    seq (map f xs) >>= (return o ListPair.unzip)

fun zipWithM f ls =
    seq (map f (ListPair.zip ls))

fun zipWithM' f ls =
    seq' (map f (ListPair.zip ls))

fun foldM _ b nil = return b
  | foldM f b (x :: xs) = f (x, b) >>= (fn b' => foldM f b' xs)

fun foldM' f b xs = ignore (foldM f b xs)

fun tabulateM n m =
    seq (List.tabulate (n, fn _ => m))

fun tabulateM' n m =
    seq' (List.tabulate (n, fn _ => m))

fun when p m = if p then m else return ()
fun unless p m = if p then return () else m
end

functor MonadEtAl (X : Monad) =
struct
local
  open X.Pointed X.Monad infix >>=

  structure Y = struct
  structure Pointed = X.Pointed
  structure Applicative = struct
  type 'a t = 'a t
  fun ** (xs, ys) = xs >>= (fn x => ys >>= (fn y => return (x y)))
  end
  end

  structure Z = ApplicativeEtAl (Y)
  structure M = Monad (X)
in
open Z M Y
end

end
