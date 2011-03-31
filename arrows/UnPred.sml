structure UnPred :> UnPred =
struct
type 'a t = 'a unpred

fun lift f p = p o f
fun neg p = not o p
fun andAlso (p, q) x = p x andalso q x
fun orElse (p, q) x = p x orelse q x
end
