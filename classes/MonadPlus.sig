signature MonadPlusI = sig
  type 'a t
  val zero : 'a t
  val ++ : 'a t * 'a t -> 'a t
end

signature MonadPlusO = sig
  include MonadPlusI

  val msum : 'a t list -> 'a t
  val guard : bool -> unit t
end

signature MonadPlus = sig
  include Monad
  structure MonadPlus : MonadPlusI
  sharing type Monad.t = MonadPlus.t
end
