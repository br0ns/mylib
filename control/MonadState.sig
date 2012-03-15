signature MonadState =
sig
  type 'a inner
  type ('a, 's) t = 's -> ('a * 's) inner

  val >>= : ('a, 's) t * ('a -> ('b, 's) t) -> ('b, 's) t
  val return : 'a -> ('a, 's) t

  val lift : 'a inner -> ('a, 's) t
  val get : ('s, 's) t
  val put : 's -> (Unit.t, 's) t
  val modify : 's UnOp.t -> (Unit.t, 's) t
  val gets : ('s -> 'a) -> ('a, 's) t
  val eval : ('a, 's) t -> 's -> 'a inner
  val exec : ('a, 's) t -> 's -> 's inner

  val mapState : (('a * 's) inner -> ('b * 's) inner) ->
                 ('a, 's) t -> ('b, 's) t
  val withState : 's UnOp.t -> ('a, 's) t -> ('a, 's) t
end

signature MonadStateP =
sig
  include MonadState
val genZero : ('a, 's) t Thunk.t
val || : ('a, 's) t BinOp.t
end
