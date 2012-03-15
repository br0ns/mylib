structure BinFn =
struct
type ('a, 'b) t = 'a * 'a -> 'b

fun lift (c2a, b2d) f (x, y) = b2d (f (c2a x, c2a y))
end
