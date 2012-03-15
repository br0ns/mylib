structure UnOp =
struct
type 'a t = 'a -> 'a

fun lift (a2b, b2a) f = b2a o f o a2b
end
