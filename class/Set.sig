signature Set = sig
  include Mono
  include "SetIN.inc"
  include "MonoFoldableIN.inc"
end

signature SetEX = sig
  include Mono
  include "MonoMonadIN.inc"
  include "MonoMonadEX.inc"
  include "MonoAltIN.inc"
  include "MonoMonadPEX.inc"
  include "MonoEnumerableIN.inc"
  include "MonoEnumerableEX.inc"
  include "MonoUnfoldableIN.inc"
  include "MonoUnfoldableEX.inc"
  include "OrderedIN.inc"
  include "OrderedEX.inc"
end
