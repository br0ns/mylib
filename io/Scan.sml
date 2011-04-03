structure Scan :> Scan =
struct
fun dropState scan read xs =
    case scan read xs of
      NONE => NONE
    | SOME (x, _) => SOME x

type s0 = substring
fun string scan = dropState scan Substring.getc o Substring.full

type s1 = TextIO.StreamIO.instream
type s2 = s1
type s3 = s1
fun instream scan is =
    TextIO.scanStream scan is

fun file scan f =
    let
      val is = TextIO.openIn f
    in
      instream scan is
      before TextIO.closeIn is
    end

fun stdIn scan () = instream scan TextIO.stdIn

type s4 = char list
fun charList scan = dropState scan List.getItem

type s5 = char list
fun charSeq scan = charList scan o Seq.foldr op:: nil

type s6 = char stream
fun charStream scan = dropState scan Stream.getl
end
