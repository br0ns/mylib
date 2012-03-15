signature Monad = sig
  type 'a t
  include "MonadIN.inc"
end

signature MonadEX =
sig
  include Monad
  include "MonadEX.inc"

  include "FuncIN.inc"
  include "FuncEX.inc"
  include "IdiomIN.inc"
  include "IdiomEX.inc"
end
