signature Range =
sig
  type t
  include "RangeIN.inc"
  include "OrderedIN.inc"
end

signature RangeEX =
sig
include Range
include "RangeEX.inc"
end
