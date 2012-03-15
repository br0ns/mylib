functor Idiom (I : Idiom) : IdiomEX =
struct
open Fn infixr $
open I infix $$ ** >> << --
open Func(
type 'a t = 'a t
fun map f a = pure f ** a
)

fun a >> b = (fn _ => fn y => y) $$ a ** b
fun a << b = (fn x => fn _ => x) $$ a ** b
fun map2 f a b = f $$ a ** b
fun map3 f a b c = f $$ a ** b ** c
fun map4 f a b c d = f $$ a ** b ** c ** d
fun a -- b = curry id $$ a ** b
fun cartesian a b = a -- b

fun mergerBy f xs =
    case xs of
      nil    => NONE
    | x ::xs => SOME $ List.foldr (fn (x, a) => curry f $$ x ** a) x xs
fun mergelBy f xs =
    case xs of
      nil    => NONE
    | x ::xs => SOME $ List.foldl (fn (x, a) => curry f $$ x ** a) x xs
end
