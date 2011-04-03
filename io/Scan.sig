signature Scan = sig
  type s0
  val string : (char, 'a, s0) scanner -> string -> 'a option
  type s1
  val file : (char, 'a, s1) scanner -> string -> 'a option
  type s2
  val stdIn : (char, 'a, s2) scanner -> 'a option thunk
  type s3
  val instream : (char, 'a, s3) scanner -> TextIO.instream -> 'a option
  type s4
  val charList : (char, 'a, s4) scanner -> char list -> 'a option
  type s5
  val charSeq : (char, 'a, s5) scanner -> char seq -> 'a option
  type s6
  val charStream : (char, 'a, s6) scanner -> char stream -> 'a option
end
