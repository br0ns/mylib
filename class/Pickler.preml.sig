signature Pickler = sig
  type t val pickle : (String.t, t, 'x) Packer.t
 
end

signature PicklerEX = sig
  type t val toString : t -> String.t
val toFile : String.t -> t Effect.t
val toStdOut : t Effect.t
val toOutstream : TextIO.outstream -> t Effect.t

val toCharList : t -> Char.t List.t
val toCharSeq : t -> Char.t Seq.t
val toCharStream : t -> Char.t Stream.t
 end