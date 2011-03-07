signature MonadErrorI = sig
  type error
  type 'a t
  val throw : error -> 'a t
  val catch : 'a t * (error -> 'a t) -> 'a t
end

signature MonadErrorO = sig
  include MonadErrorI

end

signature MonadError = sig
  include Monad
  structure MonadError : MonadErrorI
  sharing type Monad.t = MonadError.t
end
