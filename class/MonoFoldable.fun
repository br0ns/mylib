functor MonoFoldable (F : MonoFoldableBase) : MonoFoldable =
struct
open F

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

fun appr ef xs = foldr (fn (x, _) => ef x) () xs
fun appl ef xs = foldl (fn (x, _) => ef x) () xs

local
  fun appUntil fold p xs =
      (fold (fn (_, false) => false
              | (x, _) => p x
            )
            true
            xs ;
       ())
in
fun apprUntil ef xs = appUntil foldr ef xs
fun applUntil ef xs = appUntil foldl ef xs
end

fun toList xs = foldr op:: nil xs

fun concatList xss =
    List.foldr (fn (x, a) => toList x @ a) nil xss

fun concatMap f xs =
    foldr (fn (x, a) => f x @ a) nil xs

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

local
  fun find fold p xs =
      fold (fn (_, a as SOME _) => a
             | (x, NONE) =>
               if p x then
                 SOME x
               else
                 NONE
           )
           NONE
           xs
in
fun findr p xs = find foldr p xs
fun findl p xs = find foldl p xs
val find = findl
end
end

