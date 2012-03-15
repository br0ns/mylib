val fromFile : string -> t option
val toFile : string -> t effect

val fromInstream : BinIO.instream -> t option
val toOutstream : BinIO.outstream -> t effect

val fromWord8List : word8 list -> t option
val fromWord8Seq : word8 seq -> t option
val fromWord8Stream : word8 stream -> t option
val fromWord8Vector : word8 vector -> t option
val toWord8List : t -> word8 list
val toWord8Seq : t -> word8 seq
val toWord8Stream : t -> word8 stream
val toWord8Vector : t -> word8 vector
