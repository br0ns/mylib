functor Foldable
          (include Foldable
          ) :>
        FoldableO where type 'a t = 'a Foldable.t
=
struct
open Foldable

fun foldl f b xs =
    foldr (fn (x, c) => fn b => c (f (x, b))) (fn b => b) xs b

local
  fun maybe f (x, yop) =
      SOME
        (case yop of
           SOME y => f (x, y)
         | NONE   => x
        )
in
fun foldr1 f xs =
    foldr (maybe f) NONE xs
fun foldl1 f xs =
    foldl (maybe f) NONE xs
end

local
  fun foldUntil fold f b xs =
      let
        val (b, _) =
            fold
              (fn (_, a as (_, false)) => a
                | (x, (a, _)) => f (x, a)
              )
              (b, true)
              xs
      in
        b
      end
in
fun foldrUntil f b xs = foldUntil foldr f b xs
fun foldlUntil f b xs = foldUntil foldl f b xs
end

fun rightmost xs =
    foldr
      (fn (_, a as SOME _) => a
        | (x as SOME _, _) => x
      )
      NONE
      xs

fun leftmost xs =
    foldl
      (fn (_, a as SOME _) => a
        | (x as SOME _, _) => x
      )
      NONE
      xs

fun toList xs = foldr op:: nil xs

fun concat xss = foldr op@ nil xss

fun concatMap f xs =
    foldr (fn (x, a) => f x @ a) nil xs

fun conjoin xs =
    foldr (fn (x, a) => x andalso a) true xs

fun disjoin xs =
    foldr (fn (x, a) => x orelse a) false xs

fun all p xs =
    foldr (fn (x, a) => p x andalso a) true xs

fun any p xs =
    foldr (fn (x, a) => p x orelse a) false xs

fun maximumBy cmp xs =
    foldr1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => a
               | EQUAL   => a
               | GREATER => x
           )
           xs

fun minimumBy cmp xs =
    foldr1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => x
               | EQUAL   => x
               | GREATER => a
           )
           xs

fun find p xs =
    foldr (fn (_, a as SOME _) => a
            | (x, NONE) =>
              if p x then
                SOME x
              else
                NONE
          )
          NONE
          xs

fun member x xs =
    any (fn y => x = y) xs

fun notMember x xs = not (member x xs)

fun intSum xs = foldr op+ 0 xs
fun realSum xs = foldr op+ 0.0 xs
fun intProduct xs = foldr op* 1 xs
fun realProduct xs = foldr op* 1.0 xs
end

functor Foldable' (F : FoldableI) = Foldable (structure Foldable = F)
