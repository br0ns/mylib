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

  (* val fromBitList : bit list -> scannable *)
  (* val fromBitSeq : bit seq -> scannable *)
  (* val fromBitVector : bit vector -> scannable *)
  (* val fromBitSource : bit source -> scannable *)
  (* val fromBitStream : bit stream -> scannable *)

  val fromCharList : char list -> scannable option
  val fromCharSeq : char seq -> scannable option
  val fromCharStream : char stream -> scannable option

  (* val fromStringList : string list -> scannable *)
  (* val fromStringSeq : string seq -> scannable *)
  (* val fromStringVector : string vector -> scannable *)
  (* val fromStringSource : string source -> scannable *)
  (* val fromStringStream : string stream -> scannable *)
end

signature Scannable = ScannableExt
