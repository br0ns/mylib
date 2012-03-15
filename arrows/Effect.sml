structure Effect :> Effect =
struct
type 'a t = 'a -> unit

fun ignore _ _ = ()
fun attach ef x = (ef x ; x)

fun tabulate (n, ef) =
    ( Fn.repeat n (fn i => (ef i ; i + 1)) 0
    ; ()
    )

fun lift f ef = ef o f
fun iso (a2b, b2a) = (lift b2a, lift a2b)
end
