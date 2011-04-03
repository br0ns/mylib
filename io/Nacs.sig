signature Nacs = sig
  type s0
  val string : (string, 'a, s0) nacser -> 'a -> string
  type s1
  val file : (string, 'a, s1) nacser -> string -> 'a effect
  type s2
  val stdOut : (string, 'a, s2) nacser -> 'a effect
  type s3
  val outstream : (string, 'a, s3) nacser -> TextIO.outstream -> 'a effect
  type s4
  val charList : (string, 'a, s4) nacser -> 'a -> char list
  type s5
  val charSeq : (string, 'a, s5) nacser -> 'a -> char seq

  (* Notice that when *nacsing* to a stream, the whole stream must be forced.
   * Usually *scanning* is what is wanted because it makes laziness possible.
   *)
  type s6
  val charStream : (string, 'a, s6) nacser -> 'a -> char stream
end
