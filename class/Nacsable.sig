signature NacsableCore = sig
  type nacsable

  val nacs : (string, nacsable, 'x) nacser
end

signature NacsableBase = NacsableCore

signature NacsableExt = sig
  include NacsableCore

  (* Alias for {nacs} *)
  val toString : nacsable -> string
  val toFile : string -> nacsable effect
  val toStdOut : nacsable effect
  val toOutstream : TextIO.outstream -> nacsable effect

  val toCharList : nacsable -> char list
  val toCharSeq : nacsable -> char seq
  val toCharStream : nacsable -> char stream
end

signature Nacsable = NacsableExt
