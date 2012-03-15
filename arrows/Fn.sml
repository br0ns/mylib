structure Fn :> Fn =
struct
type ('a, 'b) t = 'a -> 'b

fun curry f a b = f (a, b)
fun uncurry f (a, b) = f a b
fun curry3 f a b c = f (a, b, c)
fun uncurry3 f (a, b, c) = f a b c
fun curry4 f a b c d = f (a, b, c, d)
fun uncurry4 f (a, b, c, d) = f a b c d

fun lift (c2a, b2d) f = b2d o f o c2a
fun const x _ = x
fun eta f x y = f x y
fun fix f x = f (fix f) x
fun repeat n f x =
    if n < 0
    then raise Domain
    else fix
           (fn loop =>
            fn (0, x) => x
             | (n, x) => loop (n - 1, f x)
           )
           (n, x)
fun flipc f x y = f y x
fun flip f (x, y) = f (y, x)
fun id x = x
fun ignore _ = ()
fun seal f x () = f x
fun first a (x, y) = (a x, y)
fun second a (x, y) = (x, a y)
val op o = op o
fun op <\ (x, f) y = f (x, y)
fun op \> (f, y) = f y
fun op /> (f, y) x = f (x, y)
fun op </ (x, f) = f x
val op $ = op \>
val op >- = op </
end
