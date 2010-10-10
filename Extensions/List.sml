structure List :> List =
struct
open General infix 2 $ infix 4 \< \> infix 5 ^* to
open List

local
  fun partition _ _ nil = (nil, nil)
    | partition compare pivot (x :: xs) =
      let
        val (l, g) = partition compare pivot xs
      in
        case compare x pivot of
          LESS => (x :: l, g)
        | _    => (l, x :: g)
      end
in
fun sort _ nil = nil
  | sort _ [x] = [x]
  | sort compare (x :: xs) =
    let
        val (l, g) = partition compare x xs
    in
        sort compare l @ x :: sort compare g
    end
end


fun shuffle lst = let
  val seed = (Int.fromLarge o Time.toSeconds o Time.now) ()
  val gen  = Random.rand (seed, 101010)
  fun rnd_bool _ = Random.randRange (0,2) gen = 0
  fun shuffle'  [] tail = tail
    | shuffle' [x] tail = x::tail
    | shuffle'  xs tail =
      let
        val (left, right) = List.partition rnd_bool xs
        val right' = shuffle' right tail
      in shuffle' left right'
      end
in shuffle' lst [] end;


fun leftmost nil = NONE
  | leftmost (SOME x :: _) = SOME x
  | leftmost (NONE :: r) = leftmost r

fun rightmost xs = (leftmost o rev) xs

fun allPairs xs ys =
    List.concat (
    map (fn x => map (fn y => (x, y)) ys) xs
    )

fun splitAt x = (take x, drop x)

fun allSplits xs = tabulate (length xs, xs \< splitAt)

fun consAll (x, xss) = map (x \< op::) xss

fun concatMap f xs = foldr (fn (x, a) => f x @ a) nil xs
end
