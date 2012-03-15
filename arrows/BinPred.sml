structure BinPred :> BinPred =
struct
type 'a t = 'a * 'a -> bool

fun lift a2b f (x, y) = f (a2b x, a2b y)
end
