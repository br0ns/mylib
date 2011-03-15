functor MonoMonad (M : MonoMonadBase) : MonoMonad =
struct
infix >> =<< << <=< >=> $$ --> $|
infixr >>=
open M

fun map f m = m >>= return o f
fun app f m = (map (fn x => (f x; x)) m ; ())
fun m --> f = map f m
fun f $$ m = map f m
val lift = map
fun x $| m = const x $$ m
fun m >> n = m >>= (fn x => n >>= (fn _ => return x))
fun m << n = m >>= (fn _ => n >>= (fn x => return x))

fun lift2 f a b =
    a >>= (fn a =>
    b >>= (fn b =>
    return $ f a b))
fun lift3 f a b c =
    a >>= (fn a =>
    b >>= (fn b =>
    c >>= (fn c =>
    return $ f a b c)))
fun lift4 f a b c d =
    a >>= (fn a =>
    b >>= (fn b =>
    c >>= (fn c =>
    d >>= (fn d =>
    return $ f a b c d))))

fun mergerBy _ nil = NONE
  | mergerBy f (m :: ms) =
    SOME (
    case mergerBy f ms of
      NONE   => m
    | SOME n =>
      n >>= (fn y =>
      m >>= (fn x =>
      return $ f (x, y)))
    )

fun mergelBy f ms = mergerBy f $ rev ms

fun m =<< n = n >>= m
fun (f >=> g) x = f x >>= g
fun (f <=< g) x = g x >>= f

fun forever m = m >>= (fn _ => forever m)
fun foreverWithDelay d m =
    let
fun sleep () = OS.Process.system ("sleep " ^ Real.toString (real d / 1000.0))
      fun loop m = m >>= (fn _ => (sleep () ; loop m))
    in
      loop m
    end

fun foldM _ b nil = return b
  | foldM f b (x :: xs) = f (x, b) >>= (fn b' => foldM f b' xs)
end
