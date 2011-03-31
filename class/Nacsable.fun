functor Nacsable (S : NacsableBase) : Nacsable =
struct
open S

fun toString x = Nacser.nacsString nacs x
fun toFile x = Nacser.nacsFile nacs x
end
