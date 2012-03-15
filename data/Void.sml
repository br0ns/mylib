structure Void :> Void =
struct
datatype t = T of t
fun void x = void x
end
