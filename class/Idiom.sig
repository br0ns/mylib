signature Idiom = sig
  type 'a t
  include "IdiomIN.inc"
end

signature IdiomEX = sig
  include Idiom
  include "IdiomEX.inc"

  include "FuncIN.inc"
  include "FuncEX.inc"
end
