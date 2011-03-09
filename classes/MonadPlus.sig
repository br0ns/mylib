signature MonadPlus = sig
  include Monad
  structure Alternative : AlternativeI
  sharing type Alternative.t = Monad.t
end

signature MonadPlusO = sig
  type 'a t
end
