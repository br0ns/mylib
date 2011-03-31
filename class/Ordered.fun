functor Ordered (O : OrderedBase) : Ordered =
struct
open O
fun a < b = compare (a, b) = LESS
fun a == b = compare (a, b) = EQUAL
fun a > b = compare (a, b) = GREATER
fun a <= b = a < b orelse a == b
fun a >= b = a > b orelse a == b
fun a != b = not (a == b)

fun lt a b = a < b
fun lte a b = a <= b
fun gt a b = a > b
fun gte a b = a >= b
fun eq a b = a == b
fun neq a b = a != b

fun min (a, b) = if a < b then a else b
fun max (a, b) = if a > b then a else b

fun comparing f (a, b) = compare (f a, f b)

fun inRange (a, b) x = x >= a andalso x <= b
end
