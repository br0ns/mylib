signature MonadStateP =
sig
include MonadStateCommon
val genZero : ('a, 's) t Thunk.t
val || : ('a, 's) t BinOp.t
structure Monad : MonadPEX where type 'a t = 'a outer
end
