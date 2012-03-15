val lift : 'a inner -> 'a t
val get : state t
val put : state -> Unit.t t
val modify : state UnOp.t -> Unit.t t
val gets : (state -> 'a) -> 'a t
val eval : 'a t -> state -> 'a inner
val exec : 'a t -> state -> state inner

val mapState : (('a * state) inner -> ('b * state) inner) ->
               'a t -> 'b t
val withState : state UnOp.t -> 'a t -> 'a t
