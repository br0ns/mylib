structure Scanner :> Scanner =
struct
type ('a, 'b, 'x) t = ('a, 'b, 'x) scanner
fun combine s t read = t $ s read

type s0 = int
fun scanString scan s =
    let
      fun read n =
          if n < size s then
            SOME (String.sub (s, n), n + 1)
          else
            NONE
    in
      case scan read 0 of
        NONE => NONE
      | SOME (x, _) => SOME x
    end

type s1 = TextIO.StreamIO.instream
type s2 = s1
type s3 = s1
fun scanInstream scan is =
    TextIO.scanStream scan is

fun scanFile scan f =
    let
      val is = TextIO.openIn f
    in
      scanInstream scan is
      before TextIO.closeIn is
    end

fun scanStdIn scan () = scanInstream scan TextIO.stdIn
end
