signature UnPred = sig
type 'a t = 'a -> bool

val lift : ('a -> 'b) -> 'b t -> 'a t
val andAlso : 'a t binop
val orElse : 'a t binop
val neg : 'a t unop
end
