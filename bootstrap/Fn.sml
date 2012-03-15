structure Fn =
struct
infixr $
fun f $ x = f x
fun curry f a b = f (a, b)
fun uncurry f (a, b) = f a b
fun flip f (a, b) = f (b, a)
fun id x = x
fun const x _ = x
end
