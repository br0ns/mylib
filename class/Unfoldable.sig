signature Unfoldable = sig
  type 'a t
  include "UnfoldableIN.inc"
end

signature UnfoldableEX = sig
  type 'a t
  include "UnfoldableEX.inc"
end
