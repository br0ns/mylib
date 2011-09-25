functor Scannable (S : ScannableBase) : Scannable =
struct
open S

fun dropState read xs =
    case scan read xs of
      NONE => NONE
    | SOME (x, _) => SOME x

(* type s0 = substring *)
fun fromString s = dropState Substring.getc $ Substring.full s

(* type s1 = TextIO.StreamIO.instream *)
fun fromInstream is =
    TextIO.scanStream scan is

(* type s2 = s1 *)
fun fromFile f =
    let
      val is = TextIO.openIn f
    in
      fromInstream is
      before TextIO.closeIn is
    end

(* type s3 = s1 *)
fun fromStdIn () = fromInstream TextIO.stdIn

(* type s4 = char list *)
fun fromCharList cs = dropState List.getItem cs

(* type s5 = char list *)
(* This is faster than using {Seq.getl} *)
fun fromCharSeq cs = fromCharList $ Seq.foldr op:: nil cs

fun fromCharVector cs = fromString cs

(* type s6 = char stream *)
fun fromCharStream cs = dropState Stream.getl cs

fun fromStringX getl ss =
    let
      fun read (s, ss) =
          case Substring.getc s of
            SOME (c, s) => SOME (c, (s, ss))
          | NONE =>
            case getl ss of
              SOME (s, ss) => read (Substring.full s, ss)
            | NONE => NONE
    in
      dropState read (Substring.full "", ss)
    end

(* type s7 = substring * string list *)
fun fromStringList ss = fromStringX List.getItem ss

(* type s8 = substring * string seq *)
(* This is faster than using {Seq.getl} *)
fun fromStringSeq ss = fromStringList $ Seq.foldr op:: nil ss

fun fromStringVector ss = fromStringX VectorSlice.getItem $ VectorSlice.full ss

(* type s9 = substring * string stream *)
fun fromStringStream ss = fromStringX Stream.getl ss
end
