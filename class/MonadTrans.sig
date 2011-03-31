signature MonadTransCore = sig
  type 'a t
  type 'a inner
  val liftM : 'a inner -> 'a t
end

signature MonadTransBase = MonadTransCore

signature MonadTransExt = sig
  include MonadTransCore
end

signature MonadTrans = MonadTransExt
