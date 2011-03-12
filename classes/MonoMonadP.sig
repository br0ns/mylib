signature MonoMonadPCore = sig
  include MonoMonadCore
  val zero : monad
  val || : monad * monad -> monad
end

signature MonoMonadPBase = MonoMonadPCore

signature MonoMonadPExt = sig
  include MonoMonadPCore
  val plus : monad -> monad -> monad
  val merger : monad list -> monad
  val mergel : monad list -> monad
end

signature MonoMonadP = MonoMonadPExt
