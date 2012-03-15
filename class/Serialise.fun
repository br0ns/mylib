functor Serialise (S : Serialise) : SerialiseEX =
struct
open S
open (ignore, curry, flip) Fn
val scan = binScan
val pack = binPack

fun dropState s = Option.map (fn (x, _) => x) s

fun readStream is =
    scan (fn _ => Option.map (fn x => (x, ())) $ BinIO.input1 is) ()
fun writeStream (x, os) =
    pack x (fn x => fn () => ignore $ BinIO.output1 (os, x)) ()

val fromInstream = dropState o readStream
fun toOutstream os x = writeStream (x, os)

fun fromFile file =
    case BinIO.openIn file of
      is => Exn.finally (fn _ => fromInstream is, fn _ => BinIO.closeIn is)

fun toFile file x =
    case BinIO.openOut file of
      os => Exn.finally (fn _ => toOutstream os x,
                         fn _ => BinIO.closeOut os)

val fromWord8List = dropState o scan List.getItem
fun toWord8List x = rev $ pack x (curry op::) nil

val op |> = Seq.|>
val fromWord8Seq = dropState o scan Seq.getl
fun toWord8Seq x = pack x (curry $ flip op |>) Seq.empty

fun fromWord8Stream ws = dropState $ scan Stream.getl ws
fun toWord8Stream x =
    pack x (fn w => fn k => fn ws => k $ Stream.<| (w, ws))
         Fn.id $ Stream.genEmpty ()

val fromWord8Vector =
    dropState o scan Word8VectorSlice.getItem o Word8VectorSlice.full
val toWord8Vector = Word8Vector.fromList o toWord8List
end
