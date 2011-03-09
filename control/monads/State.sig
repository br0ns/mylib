signature State = sig
  include MonadState
  type state = MonadState.state
  type 'a t = 'a MonadState.t

  val run  : 'a t -> state -> 'a * state
  val eval : 'a t -> state -> 'a
  val exec : 'a t -> state -> state

  val mapState : ('a * state -> 'b * state) -> 'a t -> 'b t
  val withState : (state -> state) -> 'a t -> 'a t
end
