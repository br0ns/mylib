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

fun shuffle xs =
    let
      val i = (Int.fromLarge o Time.toSeconds o Time.now) ()
      val rand = Random.rand (i, 42)

      fun split (x :: y :: zs) =
          let
            val (xs, ys) = split zs
          in
            (x :: xs, y :: ys)
          end
        | split xs = (xs, nil)

      fun merge (xs, nil) = xs
        | merge (nil, ys) = ys
        | merge (x :: xs, y :: ys) =
          if Random.randInt rand mod 2 = 0 then
            x :: merge (xs, y :: ys)
          else
            y :: merge (x :: xs, ys)

      fun loop (zs as _ :: _ :: _) =
          let
            val (xs, ys) = split zs
          in
            merge (loop xs, loop ys)
          end
        | loop xs = xs
    in
      loop xs
    end

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
