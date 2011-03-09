signature MonadStateI = sig
  type state
  type 'a t
  val get : state t
  val set : state -> unit t
end

signature MonadStateO = sig
  include MonadStateI

  val modify : (state -> state) -> unit t
  val gets : (state -> 'a) -> 'a t
end

signature MonadState = sig
  include Monad
  structure MonadState : MonadStateI
  sharing type Monad.t = MonadState.t
end
