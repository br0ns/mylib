signature Either =
sig
  datatype ('a, 'b) either = Left of 'a | Right of 'b
  type ('a, 'b) t = ('a, 'b) either
  exception Either

  val ofLeft : ('a, 'b) either -> 'a
  val ofRight : ('a, 'b) either -> 'b
  val either : ('a -> 'c) -> ('b -> 'c) -> ('a, 'b) either -> 'c
  val lefts : ('a, 'b) either list -> 'a list
  val rights : ('a, 'b) either list -> 'b list
  val partition : ('a, 'b) either list -> 'a list * 'b list
end
