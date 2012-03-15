signature Func = sig
  type 'a t
  include "FuncIN.inc"
end

signature FuncEX = sig
  include Func
  include "FuncEX.inc"
end
