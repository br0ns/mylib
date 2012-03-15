val <   : t binpred
val <=  : t binpred
val >   : t binpred
val >=  : t binpred
val ==  : t binpred
val !=  : t binpred
val lt  : t -> t -> bool
val lte : t -> t -> bool
val gt  : t -> t -> bool
val gte : t -> t -> bool
val eq  : t -> t -> bool
val neq : t -> t -> bool
val min : t binop
val max : t binop
val comparing : ('a -> t) -> 'a cmp
val inRange : t * t -> t unpred
