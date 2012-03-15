val adjust : ('a option -> 'a) -> 'a t -> key -> 'a t
val insert : 'a t -> key * 'a -> 'a t
val empty : 'a t
val null : 'a t unpred
val lookup : 'a t -> key -> 'a option
val remove : 'a t -> key -> 'a t
val compareKey : key cmp
val card : 'a t -> int
val foldli : ((key * 'a) * 'b -> 'b) -> 'b -> 'a t -> 'b
val foldri : ((key * 'a) * 'b -> 'b) -> 'b -> 'a t -> 'b
