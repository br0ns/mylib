functor Seq (S : SeqBase) : Seq =
struct
open S

structure M = struct
type 'a pointed = 'a t
type 'a monad = 'a t
type 'a alt = 'a t
fun return x = singleton x
fun xs >>= f = foldr op>< empty $ map f xs
val zero = empty
val op|| = op><
end

structure F = struct
type 'a foldable = 'a t
val foldr = foldr
val foldl = foldl
end

structure M = MonadP (M)
structure F = Foldable (F)

open M F S

fun cons x xs = x <| xs
fun snoc x xs = xs |> x
fun getItem xs =
    case viewl xs of
      nill => NONE
    | x <:: xs => SOME (x, xs)
val isoList = {right = toList, left = fromList}
fun sub xs n = xs !! n
fun update xs n x = modify (const x) n xs
end
