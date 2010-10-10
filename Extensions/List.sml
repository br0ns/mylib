structure List :> List =
struct
open General infix 2 $ infix 4 \< \> infix 5 ^* to
open List

local
  fun merge cmp (xs as x::xs') (ys as y::ys') zs =
      let
        val (a,b,c) = if cmp y x = LESS then (xs, ys', y) else (xs', ys, x)
      in merge cmp a b (c::zs) end
    | merge cmp xs ys zs = List.revAppend(zs, xs @ ys)

  fun mergeMany cmp   [] []   = []
    | mergeMany cmp [xs] []   = xs
    | mergeMany cmp   [] [ys] = ys
    | mergeMany cmp (a::b::xss) yss =
      mergeMany cmp xss ((merge cmp a b [])::yss)
    | mergeMany cmp xss yss = mergeMany cmp (xss @ yss) []
in
fun sort cmp lst = mergeMany cmp (map (fn x => [x]) lst) []
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
