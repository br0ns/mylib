signature MonadPCore = sig
end

signature MonadPBase = sig
  include MonadBase
  include AltCore
  sharing type monad = alt
end

signature MonadPExt = sig
end

signature MonadP = sig
  include Monad
  include AltExt
  sharing type monad = alt
end
