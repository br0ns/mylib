structure Iso :> Iso =
struct
type ('a, 'b) t = ('a -> 'b) * ('b -> 'a)

val id = (Fn.id, Fn.id)
val swap = Pair.swap
val to = Pair.fst
val from  = Pair.snd
fun map ((c2a, a2c), (b2d, d2b)) (a2b, b2a) =
    (b2d o a2b o c2a, a2c o b2a o d2b)

fun op <--> ((b2c, c2b), (a2b, b2a)) = (b2c o a2b, b2a o c2b)
end
