functor Unfoldable (X : UnfoldableBase) : Unfoldable =
struct
open X

fun scan' read s =
          case read s of
            SOME (x, s) =>
            let
              val (xs, s) = scan' read s
            in
              (write (x, xs), s)
            end
          | NONE         => (empty, s)
fun scan read s = SOME $ scan' read s

fun mk foldr = foldr write empty

fun fromList xs = mk List.foldr xs
fun fromSeq xs = mk Seq.foldr xs
fun fromVector xs = mk Vector.foldr xs
fun fromStream xs = mk Stream.foldr xs

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
