signature StateT = sig
  include MonadState
  include MonadTrans

  type state
  type 'a t
  type 'a inner
  sharing type state = MonadState.state
  sharing type t = Monad.t
  sharing type inner = MonadTrans.inner

  val run  : 'a t -> state -> ('a * state) inner
  val eval : 'a t -> state -> 'a inner
  val exec : 'a t -> state -> state inner

  val mapState : (('a * state) inner -> ('b * state) inner) -> 'a t -> 'b t
  val withState : (state -> state) -> 'a t -> 'a t
end

signature StateTPlus = sig
  include StateT
  structure Alternative : AlternativeI
  sharing type t = Monad.t = Alternative.t
end
