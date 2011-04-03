functor Nacsable (S : NacsableBase) : Nacsable =
struct
open S

fun toString x = Nacs.string nacs x
fun toFile f = Nacs.file nacs f
fun toStdOut x = Nacs.stdOut nacs x
fun toOutstream os = Nacs.outstream nacs os
fun toCharList x = Nacs.charList nacs x
fun toCharSeq x = Nacs.charSeq nacs x
fun toCharStream x = Nacs.charStream nacs x
end
