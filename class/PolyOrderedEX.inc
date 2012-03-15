val <   : 'a t * 'b t -> bool
val <=  : 'a t * 'b t -> bool
val >   : 'a t * 'b t -> bool
val >=  : 'a t * 'b t -> bool
val ==  : 'a t * 'b t -> bool
val !=  : 'a t * 'b t -> bool
val lt  : 'a t -> 'b t -> bool
val lte : 'a t -> 'b t -> bool
val gt  : 'a t -> 'b t -> bool
val gte : 'a t -> 'b t -> bool
val eq  : 'a t -> 'b t -> bool
val neq : 'a t -> 'b t -> bool
val min : 'a t binop
val max : 'a t binop
val comparing : ('a -> 'b t) -> 'a cmp
val inRange : 'a t * 'b t -> 'c t unpred
