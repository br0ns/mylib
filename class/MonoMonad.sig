signature MonoMonadCore = sig
  type monad_elm
  type monad
  val return : monad_elm -> monad
  val >>= : monad * (monad_elm -> monad) -> monad
end

signature MonoMonadBase = MonoMonadCore

signature MonoMonadExt = sig
  include MonoMonadCore

  val map : monad_elm unop -> monad unop
  val app : monad_elm effect -> monad effect
  val --> : monad * monad_elm unop -> monad
  val $$ : monad_elm unop * monad -> monad
  val lift : monad_elm unop -> monad unop
  val $| : monad_elm * monad -> monad

  val >> : monad binop
  val << : monad binop
  val lift2 : (monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad
  val lift3 : (monad_elm -> monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad -> monad
  val lift4 : (monad_elm -> monad_elm -> monad_elm -> monad_elm -> monad_elm) ->
              monad -> monad -> monad -> monad -> monad
  val mergerBy : monad_elm binop -> monad list -> monad option
  val mergelBy : monad_elm binop -> monad list -> monad option

  val =<< : (monad_elm -> monad) * monad -> monad
  val >=> : (monad_elm -> monad) * (monad_elm -> monad) -> monad_elm -> monad
  val <=< : (monad_elm -> monad) * (monad_elm -> monad) -> monad_elm -> monad
  val forever : monad unop
  val foreverWithDelay : int -> monad unop
  val foldM : ('a * monad_elm -> monad) -> monad_elm -> 'a list -> monad
end

signature MonoMonad = sig
  include MonoMonadExt
end
