structure Order :> Order =
struct (Ordered, Show, Read)
type t = order

val compare = fn (LESS, LESS)       => EQUAL
               | (EQUAL, EQUAL)     => EQUAL
               | (GREATER, GREATER) => EQUAL
               | (LESS, _)          => LESS
               | (_, LESS)          => GREATER
               | (GREATER, _)       => GREATER
               | (_, GREATER)       => LESS

val swap = fn EQUAL   => EQUAL
            | LESS    => GREATER
            | GREATER => LESS

fun isGreater x = x = GREATER
fun isLess x = x = LESS
fun isEqual x = x = EQUAL

val toString = fn GREATER => "GREATER"
                | LESS    => "LESS"
                | EQUAL   => "EQUAL"

fun showPack x write = write $ toString x

fun op >>= (m, k) s =
    case m s of
      SOME (a, s') => k a s'
    | NONE         => NONE

fun return a s = SOME (a, s)

fun fail _ = NONE

fun op || (p, q) s =
    case p s of
      x as SOME _ => x
    | NONE        => q s

fun readScan read =
    let
      infix ||
      fun t c =
          do c' <- read
           ; if c = c'
             then return c
             else fail
          end
      fun token s r =
          let
            fun loop nil = return r
              | loop (c :: cs) =
                do t c
                 ; loop cs
                end
          in
            loop $ explode s
          end
    in
      token "GREATER" GREATER ||
      token "EQUAL"   EQUAL   ||
      token "LESS"    LESS
    end
end
