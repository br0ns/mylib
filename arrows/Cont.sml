structure Cont :> Cont =
struct
type ('a, 'r) t = ('a -> 'r) -> 'r

fun return x c = c x
fun op >>= (m, k) c = m (fn a => k a c)

fun callCC f c = f c c
fun throw c a _ = c a
end
