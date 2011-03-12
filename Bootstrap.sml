(* Minimal modules (mostly types) *)
structure Fn = struct type ('a, 'b) t = 'a -> 'b end
structure Effect = struct type 'a t = 'a -> unit end
structure Thunk = struct type 'a t = unit -> 'a end
structure Cmp = struct type 'a t = 'a * 'a -> order end
structure UnOp = struct type 'a t = 'a -> 'a end
structure BinOp = struct type 'a t = 'a * 'a -> 'a
                         type 'a curried = 'a -> 'a -> 'a end
structure UnPred = struct type 'a t = 'a -> bool end
structure BinPred = struct type 'a t = 'a * 'a -> bool
                           type 'a curried = 'a -> 'a -> bool end
structure BinFn = struct type ('a, 'b) t = 'a * 'a -> 'b end

(* Some functions I can't live without *)
infixr $
fun f $ x = f x
fun curry f a b = f (a, b)
fun uncurry f (a, b) = f a b
fun id x = x
fun const x _ = x
