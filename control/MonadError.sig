signature MonadError =
sig
  type 'a inner
  type ('a, 'e) t = ('e, 'a) Either.t inner

  val >>= : ('a, 'e) t * ('a -> ('b, 'e) t) -> ('b, 'e) t
  val return : 'a -> ('a, 'e) t
  val || : ('a, 'e) t BinOp.t

  val lift : 'a inner -> ('a, 'e) t

  val throw : 'e -> ('a, 'e) t
  val catch : ('a, 'e) t * ('e -> ('a, 'e) t) -> ('a, 'e) t
  val run : ('a, 'e) t -> ('e, 'a) Either.t inner

  val mapError : (('e, 'a) Either.t inner ->
                  ('f, 'a) Either.t inner) -> ('a, 'e) t -> ('a, 'f) t
end
