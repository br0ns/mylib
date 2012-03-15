signature Binary =
sig
  type format = string
  val pack : format -> int list -> (word8, 'x) packed
  val pack1 : format -> int -> (word8, 'x) packed
  val packRepeat : format -> int list -> (word8, 'x) packed

  val scan : format -> (word8, int list, 'x) scanner
  val scan1 : format -> (word8, int, 'x) scanner
  val scanRepeat : format -> (word8, int list, 'x) scanner

  (*
   val (x, y) =
       BinIO.scanFile "foo"
       do x <- Binary.scan1 "<I"
        ; y <- Binary.scan1 ">I"
        ; return (x, y)
       end
   or
   val (x, y) =
       BinIO.scanFile "foo"
       do [x, y] <- Binary.scan "<I>I"
        ; return (x, y)
       end

val (x, y) =
    BinIO.scanFile "foo"
    do numBytes <- Scanner.underlies (Binary.Scan.word8little, scan1 "<I")
                   (* or maybe Bínary.Scan.word8little $$ scan1 "<I" *)
     ; xs       <- Scanner.repeat numBytes $ Binary.Scan.word8big
     ; return xs
    end

val BinIO.scanFile : string -> (word8, 'a, 'x) scanner -> 'a

   val s = BinIO.fromFile "foo"
   val (x, s) = Binary.Read.int32little s
   val (y, s) = Binary.Read.int32big s

   val _ =
       BinIO.packFile "foo"
       do Binary.pack1 ">I" 42
        ; Binary.pack1 "<I" 42
       end
BinIO.packFile : string -> (word8, (), 'x) packer -> ()
   *)

  structure Read : sig
    val int32big : (int, Word8Vector.t) reader
  end

  structure Write : sig
    val int32big : (int, Word8Vector.t) writer
  end

  structure Pack : sig
    val int32big : (word8, int, 'x) packer
    val word32big : (word8, word32, 'x) packer
    val word16big : (word8, word16, 'x) packer
    val word8big : (bit, word8, 'x) packer
    val int32little : (word8, int, 'x) packer
    val word32little : (word8, word32, 'x) packer
    val word16little : (word8, word16, 'x) packer
    val word8little : (bit, word8, 'x) packer

    (* or maybe without a suffix at all *)
    val int32sys : (word8, int, 'x) packer
    val word32sys : (word8, word32, 'x) packer
    val word16sys : (word8, word16, 'x) packer
    val word8sys : (bit, word8, 'x) packer
    val char : (word8, char, 'x) packer
  end

  structure Scan : sig
    val word32big : (word8, word32, 'x) packer
    val word16big : (word8, word16, 'x) packer
    val word8big : (bit, word8, 'x) packer
    val char : (word8, char, 'x) packer
    val word32little : (word8, word32, 'x) packer
    val word16little : (word8, word16, 'x) packer
    val word8little : (bit, word8, 'x) packer
  end
end
