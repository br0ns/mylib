signature MonadStateCore = sig
  type 'a monad_state
  type state
  val get : state monad_state
  val set : state -> unit monad_state
end

signature MonadStateBase = sig
  include MonadBase
  include MonadStateCore
  sharing type monad = monad_state
end

signature MonadStateExt = sig
  include MonadStateCore

  val modify : state UnOp.t -> unit monad_state
  val gets : (state -> 'a) -> 'a monad_state
end

signature MonadState = sig
  include Monad
  include MonadStateExt
  sharing type monad = monad_state
end
