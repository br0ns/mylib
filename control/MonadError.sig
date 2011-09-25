signature ErrorT = sig
  include MonadP
  type error
  type 'a inner

  val throw : error -> 'a monad
  val catch : 'a monad * (error -> 'a monad) -> 'a monad
  val run  : 'a monad -> (error, 'a) either inner

  val mapError : ((error, 'a) either inner ->
                  (error, 'b) either inner) -> 'a monad -> 'b monad
end
