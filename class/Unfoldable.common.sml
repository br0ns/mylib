struct
open ViewL infix <::
open Fn infixr $
open U

fun scanWith' scan read s =
          case scan read s of
            SOME (x, s) =>
            let
              val (xs, s) = scanWith' scan read s
            in
              (write x xs, s)
            end
          | NONE         => (genEmpty (), s)

fun scanWith scan read s = SOME $ scanWith' scan read s
fun scan read = scanWith id read

fun unpack packed = packed write $ genEmpty ()
fun runPacker pack x = pack x write $ genEmpty ()

fun mk foldr = foldr (uncurry write) $ genEmpty ()
fun fromList xs = mk List.foldr xs
fun fromVector xs = mk Vector.foldr xs
fun fromSeq xs = mk Seq.foldr xs

fun fromStream xs =
    Fn.fix (fn loop =>
            fn (xs, k) =>
               case Stream.viewl xs of
                 x <:: xs => loop (xs, k o write x)
               | nill     => k $ genEmpty ()
           ) (xs, id)
end
