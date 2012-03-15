signature MonoMonadP = sig
  include Mono
  include "MonoMonadIN.inc"
  include "MonoAltIN.inc"
end

signature MonoMonadPEX = sig
  include MonoMonadP
  include "MonoMonadPEX.inc"
  include "MonoMonadEX.inc"
end
