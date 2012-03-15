signature Map = sig
  type key
  type 'a t
  include "MapIN.inc"
  include "FoldableIN.inc"
end

signature MapEX = sig
  type key
  type 'a t
  include "FoldableEX.inc"
  include "MapEX.inc"
end
