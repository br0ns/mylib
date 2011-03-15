signature MonadErrorCore = sig
  type 'a monad_error
  type error
  val throw : error -> 'a monad_error
  val catch : 'a monad_error * (error -> 'a monad_error) -> 'a monad_error
end

signature MonadErrorBase = sig
  include MonadBase
  include MonadErrorCore
  sharing type monad = monad_error
end

signature MonadErrorExt = sig
  include MonadErrorCore
end

signature MonadError = sig
  include Monad
  include MonadErrorExt
  sharing type monad = monad_error
end
