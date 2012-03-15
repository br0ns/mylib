signature Exn =
sig
  type t = exn
  val name : t -> string
  val message : t -> string
  val throw : t -> 'a
  val finally : 'a thunk * unit effect -> 'a
  val try : 'a thunk * ('a -> 'b) * (t -> 'b) -> 'b

  val apply : ('a -> 'b) -> 'a -> (t, 'b) either
  val eval : 'a thunk -> (t, 'a) either
  val reflect : (t, 'a) either -> 'a
end
