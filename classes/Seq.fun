functor Seq (S : SeqBase) : Seq =
struct
infix <| |> >< <:: ::> >>=

open S

structure M = struct
type 'a pointed = 'a seq
type 'a monad = 'a seq
type 'a alt = 'a seq
fun return x = x <| empty
fun xs >>= f = foldr op>< empty $ map f xs
val zero = empty
val || = op><
end

structure F = struct
type 'a foldable = 'a seq
val foldr = foldr
val foldl = foldl
end

structure M = MonadP (M)
structure F = Foldable (F)

open M F S

fun singleton x = return x
end
