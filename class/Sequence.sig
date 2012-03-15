signature Sequence = sig
  type 'a t
  include "SequenceIN.inc"
  include "FuncIN.inc"
  include "FoldableIN.inc"
end

signature SequenceEX = sig
  type 'a elm = 'a
  type 'a t
  include "FuncEX.inc"
  include "IdiomIN.inc" include "IdiomEX.inc"
  include "AltIN.inc"   include "AltEX.inc"
  include "MonadIN.inc" include "MonadEX.inc"
  include "MonadPEX.inc"
  include "FoldableEX.inc"
  include "EnumerableIN.inc" include "EnumerableEX.inc"
  include "UnfoldableIN.inc" include "UnfoldableEX.inc"
  include "SequenceEX.inc"
end
