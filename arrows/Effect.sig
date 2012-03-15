signature Effect =
sig
type 'a t = 'a -> unit

val ignore : 'a t -> 'b t
val attach : 'a t -> 'a -> 'a

val tabulate : (int * int t) t

val lift : ('a -> 'b) -> 'b t -> 'a t
val iso : ('a, 'b) iso -> ('a t, 'b t) iso
end
