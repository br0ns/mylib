structure Substring =
struct
open Substring
fun concatWith s = String.concatWith s o map string
val full = all
end
