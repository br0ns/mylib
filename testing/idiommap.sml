structure S = Monad(
type 'a t = 'a list
fun >>= (m, k) = List.concat (map k m)
fun return x = [x]
)

val xs = List.tabulate (100000, fn n => n)
fun test 0 f = ()
  | test n f = (f xs ; test (n - 1) f)
val test = test 100

;test (S.map ~);
