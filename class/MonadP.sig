signature MonadPCore = sig
end

signature MonadPBase = sig
  include MonadBase
  include AltCore
  sharing type monad = alt
end

signature MonadPExt = sig
  include MonadExt
  val mapPartial : ('a -> 'a option) -> 'a monad unop
  val keep : 'a unpred -> 'a monad unop
  val reject : 'a unpred -> 'a monad unop
end

signature MonadP = sig
  include Monad
  include AltExt
  sharing type monad = alt
end
