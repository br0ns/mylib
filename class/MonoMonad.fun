functor MonoMonad (M : MonoMonad) : MonoMonadEX =
struct
open Fn infixr $
open M infix $$ $| << >> =<< >>= <=< >=>

fun map f m = m >>= return o f

fun app f m = (map (fn x => (f x; x)) m ; ())

fun f $$ m = map f m

fun x $| m = const x $$ m

fun m >> n = m >>= (fn x => n >>= (fn _ => return x))

fun m << n = m >>= (fn _ => n >>= (fn x => return x))

fun map2 f am bm =
    do a <- am
     ; b <- bm
     ; return $ f a b
    end
fun map3 f am bm cm =
    do a <- am
     ; b <- bm
     ; c <- cm
     ; return $ f a b c
    end
fun map4 f am bm cm dm =
    do a <- am
     ; b <- bm
     ; c <- cm
     ; d <- dm
     ; return $ f a b c d
    end

fun mergerBy _ nil = NONE
  | mergerBy f (m :: ms) =
    SOME (
    case mergerBy f ms of
      NONE   => m
    | SOME n =>
      do y <- n
       ; x <- m
       ; return $ f (x, y)
      end
    )

fun mergelBy f = mergerBy f o rev

fun m =<< n = n >>= m

fun (f >=> g) x = f x >>= g

fun (f <=< g) x = g x >>= f

fun forever m = m >>= (fn _ => forever m)

fun foreverWithDelay d m =
    let
      fun sleep () = OS.Process.sleep $ Time.fromMilliseconds $ LargeInt.fromInt d
      fun loop m = m >>= (fn _ => (sleep () ; loop m))
    in
      loop m
    end

fun foldlM _ b nil = return b
  | foldlM f b (x :: xs) = f (x, b) >>= (fn b' => foldlM f b' xs)

fun foldrM f b = foldlM f b o rev
end
