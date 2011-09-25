functor Sequence (S : SequenceBase) : Sequence =
struct
open S
structure MP = MonadP(
type 'a pointed = 'a sequence
type 'a monad = 'a sequence
type 'a alt = 'a sequence
val return = singleton
fun m >>= f = foldl (fn (x, xs) => f x >< xs) empty m
val zero = empty
val op|| = op><)

structure F = Foldable(
type 'a foldable = 'a sequence
val foldr = foldr
val foldl = foldl
)

structure E = Enumerable(
type 'a enumerable_element = 'a
type 'a enumerable = 'a sequence
val read = getl
)

structure U = Unfoldable(
type 'a unfoldable_element = 'a
type 'a unfoldable = 'a sequence
val write = op<|
val empty = empty
)

open MP F E U S

fun xs !! n = index n xs

fun append xs ys = xs >< ys

end
