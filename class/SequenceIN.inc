val <| : 'a * 'a t -> 'a t
val |> : 'a t * 'a -> 'a t
val getl : ('a, 'a t) reader
val getr : ('a, 'a t) reader
val >< : 'a t binop
val genEmpty : 'a t thunk
val null : 'a t unpred
val index : int -> 'a t -> 'a
val adjust : 'a unop -> int -> 'a t unop
val length : 'a t -> int
