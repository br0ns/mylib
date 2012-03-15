structure Option :> Option =
struct
open Option
type 'a t = 'a option

fun reflect e = fn SOME x => x
                 | NONE   => raise e

fun maybe b f = fn SOME x => f x
                 | NONE   => b

fun fromOption b = maybe b Fn.id

val ofSome = valOf

fun op >>= (SOME x, k) = (k x handle Match => NONE)
  | op >>= (NONE, _) = NONE
val return = SOME
fun genZero () = NONE
fun op || (x as SOME _, _) = x
  | op || (_, y) = y
end

extend Option as (MonadP)
