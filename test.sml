structure List =
struct (MonadP, Foldable, Enumerable)
open List
type 'a t = 'a list

type 'a monad = 'a list
fun >>= (xs, k) = List.concat (map k xs)
fun return x = [x]
type 'a alt = 'a list
val || = op@
fun genZero () = nil
type 'a foldable = 'a list
type 'a enumerable = 'a list
type 'a enumerable_elm = 'a
val read = getItem
end

structure Int =
struct (WithSet)
open Int
type ordered = int
end

val xs = do with Int.Set
          ; x <- Int.Set.fromList [1, 2, 4]
          ; y <- Int.Set.fromList [3, 1, 5, 1]
          ; return (x + y)
         end
(* = fromList [4, 2, 6, 2, 5, 3, 7, 3, 7, 5, 9, 5]
 * = fromList [2, 3, 4, 5, 6, 7, 9]
 *)

open Int.Set infix ==
val test = xs == Int.Set.fromList [2,3,4,5,6,7,9]

