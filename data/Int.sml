structure Int =
struct (Ordered, Show, Read, Range, Serialise)
open Int
type t = int

fun binPack x write =
    do with Writer
     ; write $ Word8.fromInt 42
    end

(* fun binPack ? = raise Fail "" *)

fun binScan read =
    do with Reader
     ; a <- read
     ; b <- read
     ; c <- read
     ; d <- read
     ; return 0
    end

fun showPack x write = write $ Int.toString x

fun readScan ? = scan StringCvt.DEC ?

fun next n = n + 1
fun prev n = n - 1
end
