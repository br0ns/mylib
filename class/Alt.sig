signature Alt = sig
  type 'a t
  include "IdiomIN.inc"
  include "AltIN.inc"
end

signature AltEX = sig
  include Alt
  include "AltEX.inc"

  include "FuncIN.inc"
  include "FuncEX.inc"
  include "IdiomEX.inc"
end
