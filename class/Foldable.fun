functor Foldable (F : FoldableBase) : Foldable =
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
  fun foldWhile fold f (b : 'b) xs =
      let
        exception Stop of 'b
      in
        fold
          (fn (x, b) =>
              let
                val (b, cont) = f (x, b)
              in
                if cont then
                  b
                else
                  raise Stop b
              end
          )
          b
          xs
          handle Stop b => b
      end
in
fun foldrWhile f b xs = foldWhile foldr f b xs
fun foldlWhile f b xs = foldWhile foldl f b xs
end

fun appr ef xs = foldr (fn (x, _) => ef x) () xs
fun appl ef xs = foldl (fn (x, _) => ef x) () xs
fun apprWhile ef xs = foldrWhile (fn (x, _) => ((), ef x)) () xs
fun applWhile ef xs = foldlWhile (fn (x, _) => ((), ef x)) () xs

fun rightmost xs =
    foldrWhile (fn (x, _) => (x, not (Option.isSome x))) NONE xs
fun leftmost xs =
    foldlWhile (fn (x, _) => (x, not (Option.isSome x))) NONE xs

fun toList xs = foldr op:: nil xs

fun concatFoldable xss = foldr op@ nil xss
fun concatList xss =
    List.foldr (fn (x, a) => toList x @ a) nil xss

fun conjoin xs =
    foldr (fn (x, a) => x andalso a) true xs

fun disjoin xs =
    foldr (fn (x, a) => x orelse a) false xs

fun all p xs =
    foldlWhile (fn (x, _) => if p x then (true, true) else (false, false)) true xs
fun any p xs =
    foldlWhile (fn (x, _) => if p x then (true, false) else (false, true)) false xs

fun maximumBy cmp xs =
    foldl1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => a
               | EQUAL   => a
               | GREATER => x
           )
           xs

fun minimumBy cmp xs =
    foldl1 (fn (x, a) =>
               case cmp (x, a) of
                 LESS    => x
               | EQUAL   => x
               | GREATER => a
           )
           xs

fun findr p xs =
    foldrWhile (fn (x, _) => if p x then (SOME x, false) else (NONE, true)) NONE xs
fun findl p xs =
    foldlWhile (fn (x, _) => if p x then (SOME x, false) else (NONE, true)) NONE xs
val find = findl

fun member x xs =
    any (fn y => x = y) xs

fun notMember x xs = not $ member x xs

fun intSum xs = foldl op+ 0 xs
fun realSum xs = foldl op+ 0.0 xs
fun intProduct xs = foldl op* 1 xs
fun realProduct xs = foldl op* 1.0 xs

local
  fun getIt fold (xs : 'a foldable) =
      let
        exception GotIt of 'a
      in
        fold (fn (x, _) => raise GotIt x) (fn _ => raise Empty) xs ()
        handle GotIt x => x
      end
in
fun first xs = getIt foldl xs
fun last xs = getIt foldr xs
end
end
