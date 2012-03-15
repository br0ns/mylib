signature MonoMonad = sig
  include Mono
  include "MonoMonadIN.inc"
end

signature MonoMonadEX = sig
  include Mono
  include "MonoMonadEX.inc"
end
