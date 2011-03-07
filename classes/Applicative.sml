functor Applicative
        (include Applicative
        ) :>
        ApplicativeO where type 'a t = 'a Applicative.t
=
struct
open Functor Applicative infix ** |* *| $$ $|

fun a $$ b = map a b
fun liftA f a = f $$ a
fun liftA2 f a b = f $$ a ** b
fun liftA3 f a b c = f $$ a ** b ** c
fun liftA4 f a b c d = f $$ a ** b ** c ** d
fun a |* b = liftA2 (fn _ => fn x => x) a b
fun a *| b = liftA2 (fn x => fn _ => x) a b
fun x $| a = (fn _ => x) $$ a
fun allPairs a b = liftA2 (fn x => x) a b
end

functor Applicative' (A : ApplicativeI) = Applicative (structure Applicative = A)

functor FunctorFromApplicative (A : ApplicativeI) :>
        FunctorI where type 'a t = 'a A.t
=
struct
open A infix **
fun map f xs = pure f ** xs
end
