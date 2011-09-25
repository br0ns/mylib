signature Exn =
sig
  type t = exn
  val name : exn -> string
  val message : exn -> string
  val throw : exn -> 'a
  val after : 'a thunk * 

  val apply : ('a -> 'b) -> 'a -> ('b, exn) either
  val eval : 'a thunk -> ('a, exn) either
  val reflect : ('a, exn) either -> 'a
  val try : 'a thunk * ('a -> 'b) * 
