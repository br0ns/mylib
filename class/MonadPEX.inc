val mapPartial : ('a -> 'a option) -> 'a t unop
val keep : 'a unpred -> 'a t unop
val reject : 'a unpred -> 'a t unop
