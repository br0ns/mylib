functor Enumerable (X : EnumerableBase) : Enumerable =
struct
open X

fun nacs write (s, empty) =
    case read s of
      SOME (x, a') => write (x, nacs write (a', empty))
    | NONE         => empty

fun mk write empty s = nacs write (s, empty)

fun toList xs = mk op:: nil xs
fun toSeq xs = mk Seq.<| Seq.empty xs
fun toVector xs = Vector.fromList $ toList xs
fun toStream xs = mk Stream.<| Stream.empty xs
fun toSource xs = Source.create read xs

(* fun scanString s = Scanner.scanString $ Scanner.combine scan s *)
(* fun scanFile s = Scanner.scanFile $ Scanner.combine scan s *)
(* fun scanStdIn s = Scanner.scanStdIn $ Scanner.combine scan s *)
(* fun scanInstream s = Scanner.scanInstream $ Scanner.combine scan s *)
(* fun scanCharList s = Scanner.scanCharList $ Scanner.combine scan s *)
(* fun scanCharSeq s = Scanner.scanCharSeq $ Scanner.combine scan s *)
(* fun scanCharVector s = Scanner.scanCharVector $ Scanner.combine scan s *)
(* fun scanCharStream s = Scanner.scanCharStream $ Scanner.combine scan s *)
(* fun scanStringList s = Scanner.scanStringList $ Scanner.combine scan s *)
(* fun scanStringSeq s = Scanner.scanStringSeq $ Scanner.combine scan s *)
(* fun scanStringVector s = Scanner.scanStringVector $ Scanner.combine scan s *)
(* fun scanStringStream s = Scanner.scanStringStream $ Scanner.combine scan s *)
end
