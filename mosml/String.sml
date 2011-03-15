structure String =
struct
open String
type char = char
fun concatWith s xs =
    case xs of
      nil     => ""
    | [x]     => x
    | x :: xs => x ^ s ^ concatWith s xs
fun isSubstring a b = true
fun isSuffix a b = true
fun scan getc strm = SOME ("", strm)
end
