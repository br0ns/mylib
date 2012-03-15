struct
open E

fun packWith pack s write stream =
    case read s of
      SOME (x, s) => packWith pack s write $ pack x write stream
    | NONE        => stream

fun pack s = packWith (fn x => fn write => fn stream => write x stream) s

fun toList xs = pack xs (Fn.curry op::) nil
fun toSeq xs = pack xs (Fn.curry Seq.<|) $ Seq.genEmpty ()
fun toVector xs = Vector.fromList (toList xs)
fun toStream xs = pack xs (Fn.curry Stream.<|) $ Stream.genEmpty ()

fun runScanner scanner = Option.map (fn (a, _) => a) o scanner read
end
