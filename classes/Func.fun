functor Func (F : FuncBase) : Func =
struct
open F infix $$ $|

val lift = map
fun app f fnc = (map (fn x => (f x ; ())) fnc ; ())
fun --> (fnc, f) = map f fnc
fun a $$ b = map a b
fun x $| a = (fn _ => x) $$ a
end
