structure UnPred :> UnPred =
struct
type 'a t = 'a -> bool

fun lift f p = p o f
fun neg p = not o p
fun both (p, q) x = p x andalso q x
fun either (p, q) x = p x orelse q x
fun xor (p, q) x = p x <> q x
fun all ps = foldl both (fn _ => true) ps
fun any ps = foldl either (fn _ => false) ps
end
