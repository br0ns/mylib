val fail : string -> 'a t
val join : 'a t t -> 'a t
val mapM : ('a -> 'b t) -> 'a list -> 'b list t
val mapMPartial : ('a -> 'b option t) -> 'a list -> 'b list t
val mapM' : ('a -> 'b t) -> 'a list -> unit t
val seq : 'a t list -> 'a list t
val seq' : 'a t list -> unit t
val =<< : ('a -> 'b t) * 'a t -> 'b t
val >=> : ('a -> 'b t) * ('b -> 'c t) -> 'a -> 'c t
val <=< : ('b -> 'c t) * ('a -> 'b t) -> 'a -> 'c t
val forever : 'a t -> 'b t
val foreverWithDelay : int -> 'a t -> 'b t
val ignore : 'a t -> unit t
val keepM : ('a -> bool t) -> 'a list -> 'a list t
val rejectM : ('a -> bool t) -> 'a list -> 'a list t
val mapAndUnzipM : ('a -> ('b * 'c) t) -> 'a list ->
                   ('b list * 'c list) t
val zipWithM : ('a * 'b -> 'c t) -> 'a list * 'b list -> 'c list t
val zipWithM' : ('a * 'b -> 'c t) -> 'a list * 'b list -> unit t
val foldlM : ('a * 'b -> 'b t) -> 'b -> 'a list -> 'b t
val foldlM' : ('a * 'b -> 'b t) -> 'b -> 'a list -> unit t
val foldrM : ('a * 'b -> 'b t) -> 'b -> 'a list -> 'b t
val foldrM' : ('a * 'b -> 'b t) -> 'b -> 'a list -> unit t
val tabulateM : int -> (int -> 'a t) -> 'a list t
val tabulateM' : int -> (int -> 'a t) -> unit t
val when : bool -> unit t -> unit t
val unless : bool -> unit t -> unit t
