signature MonadPlusO = sig
  type 'a t

  val msum : 'a t list -> 'a t
  val guard : bool -> unit t
end

signature MonadPlus = sig
  include Monad
  structure Alternative : AlternativeI
  sharing type Alternative.t = Monad.t
end
