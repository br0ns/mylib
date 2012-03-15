structure BinOp =
struct
type 'a t = 'a * 'a -> 'a

val lift = BinFn.lift
end
