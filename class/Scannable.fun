functor Scannable (S : ScannableBase) : Scannable =
struct
open S

fun fromString x = Scan.string scan x
fun fromFile x = Scan.file scan x
fun fromStdIn x = Scan.stdIn scan x
fun fromInstream x = Scan.instream scan x
fun fromCharList x = Scan.charList scan x
fun fromCharSeq x = Scan.charSeq scan x
fun fromCharStream x = Scan.charStream scan x
end
