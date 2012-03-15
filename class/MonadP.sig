signature MonadP =
sig
  type 'a t
  include "AltIN.inc"
  include "MonadIN.inc"
end

signature MonadPEX =
sig
  include MonadP
  include "MonadPEX.inc"
  include "MonadEX.inc"
  include "AltEX.inc"

  include "FuncIN.inc"
  include "FuncEX.inc"
  include "IdiomIN.inc"
  include "IdiomEX.inc"
end
