structure Cmp =
struct
type 'a t = 'a * 'a -> order
fun map f c (x, y) = c (f x, f y)
end
