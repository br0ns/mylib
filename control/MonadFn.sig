signature MonadFn =
sig
  type 'a inner
  type ('a, 'b) t = 'a -> 'b inner
                             include MonadPEX
type
