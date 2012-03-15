signature Either =
sig
  datatype t = datatype either
  exception Either

  val swap : ('a, 'b) t -> ('b, 'a) t
  val ofLeft : ('a, 'b) t -> 'a
  val ofRight : ('a, 'b) t -> 'b
  val ofEither : ('a, 'a) t -> 'a
  val either : ('a -> 'c) * ('b -> 'c) -> ('a, 'b) t -> 'c
  val lefts : ('a, 'b) t list -> 'a list
  val rights : ('a, 'b) t list -> 'b list
  val partition : ('a, 'b) t list -> 'a list * 'b list
  val map : ('a -> 'c) * ('b -> 'd) -> ('a, 'b) t -> ('c, 'd) t
  (* Mnemonic: 'LEFT' is 'LESS' *)
  val collate : 'a cmp * 'b cmp -> ('a, 'b) t cmp
  val iso : ('a, 'c) iso * ('b, 'd) iso -> (('a, 'b) t, ('c, 'd) t) iso
end
