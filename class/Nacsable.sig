signature NacsableCore = sig
  type nacsable
  val nacs : (string, nacsable, 'x) nacser
end

signature NacsableBase = NacsableCore

signature NacsableExt = sig
  include NacsableCore

  (* val toBitStream : nacsable -> bit stream *)
  (* val toCharStream : nacsable -> char stream *)
  val toString : nacsable -> string
  val toFile : string -> nacsable effect
  (* val toStdOut : scannable effect *)
  (* val toOutstream : outstream -> scannable effect *)

  (* val toCharList : scannable -> char list *)
  (* val toCharSeq : scannable -> char seq *)
  (* val toCharVector : scannable -> char vector *)
  (* val toCharStream : scannable -> char stream *)
end

signature Nacsable = NacsableExt
