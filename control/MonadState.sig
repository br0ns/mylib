signature StateT = sig
  include Monad
  type state
  type 'a inner

  val get : state monad
  val put : state -> unit monad
  val modify : state unop -> unit monad
  val gets : (state -> 'a) -> 'a monad
  val run  : 'a monad -> state -> ('a * state) inner
  val eval : 'a monad -> state -> 'a inner
  val exec : 'a monad -> state -> state inner

  val mapState : (('a * state) inner -> ('b * state) inner) ->
                 'a monad -> 'b monad
  val withState : (state -> state) -> 'a monad -> 'a monad
end
