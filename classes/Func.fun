functor Func (F : FuncBase) : Func =
struct
open F infix $$ $| --> <--

val lift = map
fun app f a = (map (fn x => (f x ; ())) a ; ())
fun a --> f = map f a
fun f <-- a = a --> f
fun a $$ b = map a b
fun x $| a = (fn _ => x) $$ a
end
