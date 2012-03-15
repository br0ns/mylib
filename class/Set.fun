functor Set (S : Set) : SetEX =
struct (MonoMonadP, MonoFoldable, MonoEnumerable, MonoUnfoldable, Ordered)
open MonoFoldable(S)
open S

val singleton = insert empty
fun union s = foldl (fn (e, s) => insert s e) s

fun >>= (s, k) = foldl (fn (e, s') => union (k e) s') empty s
val return = singleton
fun genZero ? = empty
val op || = Fn.uncurry union

fun split s = let val e = first s in (e, remove s e) end

fun read s = SOME (split s) handle Empty => NONE

fun insert s e = union (singleton e) s

fun write e s = insert s e
val genEmpty = genZero

fun compare (s, t) =
    case (read s, read t) of
      (NONE, NONE)   => EQUAL
    | (SOME _, NONE) => GREATER
    | (NONE, SOME _) => LESS
    | (SOME (se, s'), SOME (te, t')) =>
      case compareElm (se, te) of
        EQUAL => compare (s', t')
      | order => order
end
