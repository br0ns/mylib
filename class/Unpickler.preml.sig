signature Unpickler = sig
  type t val unpickle : (char, t, 'x) Scanner.t
 
end

signature UnpicklerEX = sig
  type t val fromString : String.t -> t Option.t
val fromFile : String.t -> t Option.t
val fromStdIn : t Option.t Thunk.t
val fromInstream : TextIO.instream -> t Option.t

val fromCharList : Char.t List.t -> t Option.t
val fromCharSeq : Char.t Seq.t -> t Option.t
val fromCharStream : Char.t Stream.t -> t Option.t

val fromStringList : String.t List.t -> t Option.t
val fromStringSeq : String.t Seq.t -> t Option.t
val fromStringVector : String.t Vector.t -> t Option.t
val fromStringStream : String.t Stream.t -> t Option.t
 end