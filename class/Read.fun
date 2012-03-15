functor Read (R : Read) : ReadEX =
struct
open R

fun dropState read xs =
    case readScan read xs of
      NONE => NONE
    | SOME (x, _) => SOME x

(* type s0 = substring *)
fun read s = valOf $ dropState Substring.getc $ Substring.full s
    handle Option => raise Fail ("read \"" ^ s ^ "\"")

fun reads s =
    let
      fun loop s =
          case readScan Substring.getc s of
            SOME (x, s) => x :: loop s
          | NONE        => nil
    in
      loop $ Substring.full s
    end

(* type s1 = TextIO.StreamIO.instream *)
fun readFromInstream is =
    TextIO.scanStream readScan is

fun readsFromInstream is =
    case TextIO.scanStream readScan is of
      SOME x => x :: readsFromInstream is
    | NONE   => nil

(* type s2 = s1 *)
fun fromFile read f =
    let
      val is = TextIO.openIn f
    in
      Exn.finally (fn _ => read is, fn _ => TextIO.closeIn is)
    end

val readFromFile = fromFile readFromInstream
val readsFromFile = fromFile readsFromInstream

(* type s3 = s1 *)
fun readFromStdIn () = readFromInstream TextIO.stdIn
fun readsFromStdIn () = readsFromInstream TextIO.stdIn
end
