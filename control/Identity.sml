structure Identity =
struct (Monad)
type 'a t = 'a
fun return x = x
fun op>>= (m, k) = k m
end
