functor Func (F : Func) : FuncEX =
struct
open F infix $$ $|
fun app f a = (map (fn x => (f x ; ())) a ; ())
fun a $$ b = map a b
fun x $| a = (fn _ => x) $$ a
end