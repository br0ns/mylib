structure Iso =
struct
type ('a, 'b) t = {from : 'b -> 'a, to : 'a -> 'b}

fun iso (to, from) = {to = to, from = from}
end
