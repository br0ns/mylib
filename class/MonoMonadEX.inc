val map : elm unop -> t unop
val map2 : (elm -> elm -> elm) ->
           t -> t -> t
val map3 : (elm -> elm -> elm -> elm) ->
           t -> t -> t -> t
val map4 : (elm -> elm -> elm -> elm -> elm) ->
           t -> t -> t -> t -> t
val app : elm effect -> t effect
val $$ : elm unop * t -> t
val $| : elm * t -> t

val >> : t binop
val << : t binop
val mergerBy : elm binop -> t list -> t option
val mergelBy : elm binop -> t list -> t option

val =<< : (elm -> t) * t -> t
val >=> : (elm -> t) * (elm -> t) -> elm -> t
val <=< : (elm -> t) * (elm -> t) -> elm -> t
val forever : t unop
val foreverWithDelay : int -> t unop
val foldlM : ('a * elm -> t) -> elm -> 'a list -> t
val foldrM : ('a * elm -> t) -> elm -> 'a list -> t
