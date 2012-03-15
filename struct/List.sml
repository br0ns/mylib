structure List =
struct (Sequence)
open List
type 'a t = 'a list
val op <| = op ::
fun xs |> x = xs @ [x]
val getl = getItem
fun getr xs = Option.map (Pair.mapSnd rev) $ getl $ rev xs
val op >< = op @
fun genEmpty _ = nil
fun index n xs = nth (xs, n)
fun adjust f 0 (x :: xs) = f x :: xs
  | adjust f n (x :: xs) = x :: adjust f (n - 1) xs
  | adjust _ _ _ = raise Subscript
end
