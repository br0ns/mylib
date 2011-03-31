functor Scannable (S : ScannableBase) : Scannable =
struct
open S

fun fromString x = Scanner.scanString scan x
fun fromFile x = Scanner.scanFile scan x
end
