signature MonoMonadPCore = sig
  include MonoMonadCore
  val zero : monad
  val || : monad * monad -> monad
end

signature MonoMonadPBase = MonoMonadPCore

signature MonoMonadPExt = sig
  include MonoMonadPCore
  val plus : monad -> monad -> monad
  val merge : monad list -> monad
end

signature MonadP = sig
  include Monad
  include AltExt
  sharing type monad = alt
end
