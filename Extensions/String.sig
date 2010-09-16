signature String =
sig
  include STRING
  where type string = string
    and type char = Char.char

(* type stream *)
(* val stream : string -> stream *)
(* val reader : (char, stream) reader *)

val tabulate : int * (int -> char) -> string

(* Max width -> text -> wordwrapped text *)
val wordwrap : int -> string -> string

(* Tab width -> text with tabs -> text without tabs *)
val untabify : int -> string -> string

val spaces : int -> string
end
