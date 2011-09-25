signature Error = sig
  include MonadError
  type error = MonadError.error
  type 'a t = 'a MonadError.monad_error

  val noMsg : 'a t
  val stringMsg : string -> 'a t
  val run  : 'a t -> state -> 'a * state
  val eval : 'a t -> state -> 'a
  val exec : 'a t -> state -> state

  val mapState : ('a * state -> 'b * state) -> 'a t -> 'b t
  val withState : (state -> state) -> 'a t -> 'a t
end
