signature PolyOrdered = sig
  type 'a t
  include "PolyOrderedIN.inc"
end

signature PolyOrderedEX = sig
  type 'a t
  include "PolyOrderedEX.inc"
end
