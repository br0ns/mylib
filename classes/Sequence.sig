signature Sequence = sig
  include Foldable
  include MonadPlus
  type 'a t
  sharing type Foldable.t = Monad.t = t

end
