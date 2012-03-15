structure Unit :> Unit =
struct (Ordered)
type t = unit
fun compare ((), ()) = EQUAL
end
