functor App (A : App) : AppInstance =
struct
open A infix **


structure A = struct
open A
type 'a func = 'a app
fun map f xs = pure f ** xs
end

structure F = Func (A)
structure P = Pointed (A)
open F P A infix ** |* *|

fun lift2 f a b = f $$ a ** b
fun lift3 f a b c = f $$ a ** b ** c
fun lift4 f a b c d = f $$ a ** b ** c ** d
fun a >> b = (fn _ => fn x => x) $$ a ** b
fun a << b = (fn x => fn _ => x) $$ a ** b
fun a -- b = (fn x => fn y => (x, y)) $$ a ** b
fun cartesian a b = lift2 (fn x => fn y => (x, y)) a b

fun mergerBy f xs =
    case xs of
      nil    => NONE
    | x ::xs => SOME $ List.foldr (fn (x, a) => curry f $$ x ** a) x xs
fun mergelBy f xs =
    case xs of
      nil    => NONE
    | x ::xs => SOME $ List.foldl (fn (x, a) => curry f $$ x ** a) x xs
end
