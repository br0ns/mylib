structure Emb =
struct
type ('a, 'b) t = {from : 'b -> 'a option, to : 'a -> 'b}

fun emb (to, from) = {to = to, from = from}
end
