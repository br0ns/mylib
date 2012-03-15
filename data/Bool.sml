structure Bool :> Bool =
struct (Ordered, Show, Read)
open Bool
datatype t = datatype bool

val compare = fn (true, false) => GREATER
               | (false, true) => LESS
               | _             => EQUAL

fun isTrue b = b
val isFalse = not

val readScan = scan
fun showPack x write = write $ toString x
end
