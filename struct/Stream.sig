type 'a t
val create : ('a, 'x) reader * 'x -> 'a t
val get : ('a, 'a t) reader


type 'a t = ('a, univ) reader * univ
fun create read = ...
fun get (read, x) = read x
