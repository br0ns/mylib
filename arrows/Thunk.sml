structure Thunk :> Thunk =
struct
type 'a t = unit -> 'a

fun force th = th ()

fun eager x () = x

fun delay th () = force (th ())

fun lift f th = f o th

fun iso (a2b, b2a) = (lift a2b, lift b2a)

val memoise = Lazy.memoise
end
