signature MonoMonadPCore = sig
  include MonoMonadCore
  val zero : monad
  val || : monad binop
end

signature MonoMonadPBase = MonoMonadPCore

signature MonoMonadPExt = sig
  include MonoMonadPCore
  val plus : monad -> monad -> monad
  val merger : monad list -> monad
  val mergel : monad list -> monad
  val mapPartial : (monad_elm -> monad_elm option) -> monad -> monad
end

signature MonoMonadP = MonoMonadPExt
