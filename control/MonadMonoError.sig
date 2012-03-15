signature MonadMonoError =
sig
  type error
  type 'a inner
  include MonadPEX
  where type 'a t = (error, 'a) Either.t inner

  val noMsg  : error
  val lift : 'a inner -> 'a t

  val throw : error -> 'a t
  val catch : 'a t * (error -> 'a t) -> 'a t
  val run : 'a t -> (error, 'a) Either.t inner

  val mapError : ((error, 'a) Either.t inner ->
                  (error, 'a) Either.t inner) -> 'a t -> 'a t
end
