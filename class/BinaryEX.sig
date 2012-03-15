val fromFile : string -> t option
val toFile : string -> t effect

val fromInstream : instream -> t option
val toOutstream : outstream -> t effect

val fromCharList : char list -> t option
val fromCharSeq : char seq -> t option
val fromCharStream : char stream -> t option
val fromCharVector : char vector -> t option
val fromStringList : string list -> t option
val fromStringSeq : string seq -> t option
val fromStringVector : string vector -> t option
val fromStringStream : string stream -> t option
val toCharList : t -> char list
val toCharSeq : t -> char seq
val toCharStream : t -> char stream
val toCharVector : t -> char vector

val fromWord8List : word8 list -> t option
val fromWord8Seq : word8 seq -> t option
val fromWord8Stream : word8 stream -> t option
val fromWord8Vector : word8 vector -> t option
val toWord8List : t -> word8 list
val toWord8Seq : t -> word8 seq
val toWord8Stream : t -> word8 stream
val toWord8Vector : t -> word8 vector
