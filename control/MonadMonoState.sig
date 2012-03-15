signature MonadMonoState =
sig
  type state
  type 'a inner
  include MonadEX
  where type 'a t = state -> ('a * state) inner

  include "MonadMonoStateEX.inc"
end

signature MonadMonoStateP =
sig
  type state
  type 'a inner
  include MonadPEX
  where type 'a t = state -> ('a * state) inner

  include "MonadMonoStateEX.inc"
end
