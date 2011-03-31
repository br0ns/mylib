structure Nacser :> Nacser =
struct
type ('a, 'b, 'x) t = ('a, 'b, 'x) nacser
fun combine s t write = t $ s write

fun mk toString write (x, s) = write (toString x, s)

type s0 = string list
fun nacsString nacs x = concat $ rev $ nacs op:: (x, nil)

type s1 = unit
fun nacsFile nacs f x =
    let
      val os = TextIO.openOut f
      fun write (s, _) = TextIO.output (os, s)
    in
      nacs write (x, ())
    ; TextIO.closeOut os
    end
end
