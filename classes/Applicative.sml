functor Applicative
        (include Applicative
        ) :>
        ApplicativeO where type 'a t = 'a Applicative.t
=
struct
open Pointed Applicative infix ** |* *|

fun lift2 f a b = return f ** a ** b
fun lift3 f a b c = return f ** a ** b ** c
fun lift4 f a b c d = return f ** a ** b ** c ** d
fun a |* b = lift2 (fn _ => fn x => x) a b
fun a *| b = lift2 (fn x => fn _ => x) a b
fun allPairs a b = lift2 (fn x => fn y => (x, y)) a b

fun curry f a b = f (a, b)
fun mergeBy _ nil = raise Empty
  | mergeBy f (x :: xs) =
    List.foldl (fn (x, a) => lift2 (curry f) x a) x xs
end


functor ApplicativeEtAl (X : Applicative) =
struct
local
  open X.Pointed X.Applicative infix **

  structure Y = struct
  structure Functor = struct
  type 'a t = 'a t
  fun map f xs = return f ** xs
  end
  end

  structure F = Functor (Y)
  structure P = Pointed (X)
  structure A = Applicative (X)
in
open F P A Y
end

end
