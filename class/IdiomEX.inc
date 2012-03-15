val >> : 'a t * 'b t -> 'b t
val << : 'a t * 'b t -> 'a t
val -- : 'a t * 'b t -> ('a * 'b) t
val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
val map3 : ('a -> 'b -> 'c -> 'r) ->
            'a t -> 'b t -> 'c t -> 'r t
val map4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
            'a t -> 'b t -> 'c t -> 'd t -> 'r t
val mergerBy : 'a binop -> 'a t list -> 'a t option
val mergelBy : 'a binop -> 'a t list -> 'a t option
val cartesian : 'a t -> 'b t -> ('a * 'b) t
