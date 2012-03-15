structure Reader :> Reader =
struct
type ('a, 'x) t = 'x -> ('a * 'x) option

open StateTP(Option)

val returnO = lift
fun run m = valOf o eval m

fun fail ? = returnO NONE ?

end
