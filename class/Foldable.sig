signature Foldable = sig
  type 'a t
  include "FoldableIN.inc"
end

signature FoldableEX = sig
  type 'a t
  include "FoldableEX.inc"
end
