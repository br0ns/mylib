signature Enumerable = sig
  type 'a elm
  type 'a t
  include "EnumerableIN.inc"
end

signature EnumerableEX = sig
  type 'a elm
  type 'a t
  include "EnumerableEX.inc"
end
