structure ID =
struct
structure M = Monad(
type 'a pointed = 'a
fun return x = x
type 'a monad = 'a
fun m >>= k = k m
)

open M
end
