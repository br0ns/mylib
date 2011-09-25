signature ScannableCore = sig
  type scannable

  val scan : (char, scannable, 'x) scanner
end

signature ScannableBase = ScannableCore

signature ScannableExt = sig
  include ScannableCore

  val fromString : string -> scannable option
  val fromFile : string -> scannable option
  val fromStdIn : scannable option thunk
  val fromInstream : TextIO.instream -> scannable option

  val fromCharList : char list -> scannable option
  (* Alias for {fromString} *)
  val fromCharVector : char vector -> scannable option
  val fromCharSeq : char seq -> scannable option
  val fromCharStream : char stream -> scannable option

  val fromStringList : string list -> scannable option
  val fromStringSeq : string seq -> scannable option
  val fromStringVector : string vector -> scannable option
  val fromStringStream : string stream -> scannable option
end

signature Scannable = ScannableExt
