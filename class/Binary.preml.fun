functor Binary (B : Binary) : BinaryEX =
struct
open B
val dropState = Option.map (fn (x, _) => x)

val readStream = scan BinIO.input1
val writeStream = pack (fn (x, s) => (BinIO.output1 (s, x) ; os))

val fromInstream = dropState o readStream
fun toOutstream os x = writeStream (x, os)

fun fromFile file =
    case BinIO.openIn of
      is => Exn.finally (fn _ => fromInstream is, fn _ => BinIO.closeIn is)

fun toFile file =
    case BinIO.openOut of
      os => Exn.finally (fn _ => toOutstream os, fn _ => BinIO.closeOut os)

val fromWord8List = dropState o scan List.getItem
fun toWord8List x = rev $ pack op:: (x, nil)

val op |> = Seq.|>
val fromWord8Seq = dropState o scan Seq.getl
fun toWord8Seq x = pack (fn (w, s) => s |> w) (x, Seq.empty)

fun fromWord8Stream ws = dropState $ scan Stream.getl ws
val toWord8Stream = Stream.fromList o toWord8List

val fromWord8Vector =
    dropState o scan Word8VectorSlice.getItem o Word8VectorSlice.full
val toWord8Vector = Word8Vector.fromList o toWord8List
end