signature MonoMonadCore = sig
  type monad_elm
  type monad
  val return : monad_elm -> monad
  val >>= : monad * (monad_elm -> monad) -> monad
end

signature MonoMonadBase = MonoMonadCore

signature MonoMonadExt = sig
  include MonoMonadCore

  val map : monad_elm UnOp.t -> monad UnOp.t
  val app : monad_elm Effect.t -> monad Effect.t
  val --> : monad * monad_elm UnOp.t -> monad
  val $$ : monad_elm UnOp.t * monad -> monad
  val lift : monad_elm UnOp.t -> monad UnOp.t
  val $| : monad_elm * monad -> monad

  val >> : monad BinOp.t
  val << : monad BinOp.t
  val lift2 : monad_elm BinOp.curried ->
              monad BinOp.curried
  val lift3 : (monad_elm -> monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad -> monad
  val lift4 : (monad_elm -> monad_elm -> monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad -> monad -> monad
  val mergerBy : monad_elm BinOp.t -> monad list -> monad option
  val mergelBy : monad_elm BinOp.t -> monad list -> monad option

  val =<< : (monad_elm -> monad) * monad -> monad
  val >=> : (monad_elm -> monad) * (monad_elm -> monad) -> monad_elm -> monad
  val <=< : (monad_elm -> monad) * (monad_elm -> monad) -> monad_elm -> monad
  val forever : monad UnOp.t
  val foreverWithDelay : int -> monad UnOp.t
  val foldM : ('a * monad_elm -> monad) -> monad_elm -> 'a list -> monad
end

signature MonoMonad = sig
  include MonoMonadExt
end
