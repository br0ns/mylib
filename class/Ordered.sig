signature Ordered = sig
  type t
  include "OrderedIN.inc"
end

signature OrderedEX = sig
  type t
  include "OrderedEX.inc"
end
