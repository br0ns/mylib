(* Some types *)
type 'a effect = 'a -> unit
type 'a thunk = unit -> 'a
type 'a cmp = 'a * 'a -> order
type 'a unop = 'a -> 'a
type 'a binop = 'a * 'a -> 'a
type 'a unpred = 'a -> bool
type 'a binpred = 'a * 'a -> bool

type ('a, 'b) iso = {left : 'b -> 'a, right : 'a -> 'b}
type ('a, 'b) emb = {left : 'b -> 'a option, right : 'a -> 'b}

datatype ('a, 'b) either = Left of 'a | Right of 'b
datatype ('a, 'b) product = & of 'a * 'b

(* Some functions I can't live without *)
infixr $
fun f $ x = f x
fun curry f a b = f (a, b)
fun uncurry f (a, b) = f a b
fun id x = x
fun const x _ = x
fun die s =
    (print ("An unexpected error occured in MyLib.\n\
            \Please email me at mortenbp@gmail.com.\n\
            \\n\
            \Error message:\n\
            \" ^ s)
   ; OS.Process.exit (1))
