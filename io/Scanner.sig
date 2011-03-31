signature Scanner = sig
  type ('a, 'b, 'x) t =
       ('x -> ('a * 'x) option) -> 'x -> ('b * 'x) option

  val combine : ('a, 'b, 'x) scanner ->
                ('b, 'c, 'x) scanner ->
                ('a, 'c, 'x) scanner

  type s0
  val scanString : (char, 'a, s0) scanner ->
                   string -> 'a option
  type s1
  val scanFile : (char, 'a, s1) scanner ->
                 string -> 'a option
  (* type s2 *)
  (* val scanStdIn : (char, 'a, s2) scanner -> *)
  (*                 'a option thunk *)
  (* type s3 *)
  (* val scanInstream : (char, 'a, s3) scanner -> *)
  (*                    instream -> 'a option *)
  (* type s4 *)
  (* val scanCharList : (char, 'a, s4) scanner -> *)
  (*                    char list -> 'a option *)
  (* type s5 *)
  (* val scanCharSeq : (char, 'a, s5) scanner -> *)
  (*                   char seq -> 'a option *)
  (* type s6 *)
  (* val scanCharVector : (char, 'a, s6) scanner -> *)
  (*                      char vector -> 'a option *)
  (* type s7 *)
  (* val scanCharStream : (char, 'a, s7) scanner -> *)
  (*                      char stream -> 'a option *)
  (* type s8 *)
  (* val scanStringList : (char, 'a, s8) scanner -> *)
  (*                      string list -> 'a option *)
  (* type s9 *)
  (* val scanStringSeq : (char, 'a, s9) scanner -> *)
  (*                     string seq -> 'a option *)
  (* type s10 *)
  (* val scanStringVector : (char, 'a, s10) scanner -> *)
  (*                        string vector -> 'a option *)
  (* type s11 *)
  (* val scanStringStream : (char, 'a, s11) scanner -> *)
  (*                        string stream -> 'a option *)
end
