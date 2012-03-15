structure Emb :> Emb =
struct
type ('a, 'b) t = ('a -> 'b) * ('b -> 'a Option.t)

val id = (Fn.id, SOME)
val to = Pair.fst
val from  = Pair.snd

fun op <--> ((b2c, c2bop), (a2b, b2aop)) =
    (b2c o a2b, fn c => Option.>>= (c2bop c, b2aop))
end
