structure Exn : Exn =
struct
type t = exn
val name = General.exnName
val message = General.exnMessage
fun throw e = raise e
fun try (th, fv, fe) = fv (th ()) handle e => fe e
fun past ef x = (ef () ; x)
fun finally (th, ef) = try (th, past ef, throw o past ef)

fun apply f x = RIGHT (f x) handle e => LEFT e
fun eval th = apply th ()
val reflect = fn LEFT e  => raise e
               | RIGHT x => x
end
