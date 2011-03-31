functor Sequence (S : SequenceBase) : Sequence =
struct
open S
structure MP = MonadP(
val return = singleton
fun m >>= f = foldl (fn (x, xs) => f x >< xs) empty m
val zero = empty
val op|| = op><)

structure F = Foldable(S)

structure E = Enumerable(
val read = getl
val write = op<|)

open MP F E S


end
