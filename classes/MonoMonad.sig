signature MonoMonadCore = sig
  type monad_elm
  type monad
  val return : monad_elm -> monad
  val >>= : monad * (monad_elm -> monad) -> monad
end

signature MonoMonadExt = sig
  include MonoMonadCore

  val map : (monad_elm -> monad_elm) -> monad -> monad
  val app : (monad_elm -> '_) -> monad -> unit
  val --> : monad * (monad_elm -> monad_elm) -> monad
  val $$ : (monad_elm -> monad_elm) * monad -> monad
  val lift : (monad_elm -> monad_elm) -> monad -> monad
  val $| : monad_elm * monad -> monad

  val >> : monad * monad -> monad
  val << : monad * monad -> monad
  val lift2 : (monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad
  val lift3 : (monad_elm -> monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad -> monad
  val lift4 : (monad_elm -> monad_elm -> monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad -> monad -> monad
  val mergeBy : (monad_elm * monad_elm -> monad_elm) -> monad list -> monad

  val =<< : (monad_elm -> monad) * monad -> monad
  val >=> : (monad_elm -> monad) * (monad_elm -> monad) -> monad_elm -> monad
  val <=< : (monad_elm -> monad) * (monad_elm -> monad) -> monad_elm -> monad
  val forever : monad -> monad
  val foreverWithDelay : int -> monad -> monad
  val foldM : ('a * monad_elm -> monad) -> monad_elm -> 'a list -> monad
end

signature MonoMonad = sig
  include MonoMonadExt
end
