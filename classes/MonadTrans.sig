signature MonadTransI = sig
  type 'a t
  type 'a inner
  val liftM : 'a inner -> 'a t
end

signature MonadTransO = sig
  include MonadTransI
end

signature MonadTrans = sig
  structure MonadTrans : MonadTransI
end
