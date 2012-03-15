(* Here's your new environment ma'am. Sign here and here please. *)
structure TopLevel =
struct
(* type 'a effect = 'a -> unit *)
(* type 'a thunk = unit -> 'a *)
(* type 'a cmp = 'a * 'a -> order *)
(* type 'a unop = 'a -> 'a *)
(* type 'a binop = 'a * 'a -> 'a *)
(* type 'a unpred = 'a -> bool *)
(* type 'a binpred = 'a * 'a -> bool *)

(* type ('a, 'b) iso = ('a, 'b) Iso.t *)
(* type ('a, 'b) emb = ('a, 'b) Emb.t *)

(* type ('a, 'b) viewl = ('a, 'b) ViewL.t *)
(* type ('a, 'b) viewr = ('a, 'b) ViewR.t *)
(* type ('a, 'b) either = ('a, 'b) Either.t *)
(* type ('a, 'b) product = ('a, 'b) Product.t *)

(* type ('a, 'x) reader = 'x -> ('a * 'x) option *)
(* type ('a, 'x) writer = 'a * 'x -> 'x *)
(* type ('a, 'b, 'x) scanner = ('a, 'x) reader -> ('b, 'x) reader *)
(* type ('a, 'b, 'x) nacser = ('a, 'x) writer -> ('b, 'x) writer *)

(* type 'a lazy = 'a Lazy.t *)
(* type 'a seq = 'a Seq.t *)
(* type 'a stream = 'a Stream.t *)

val op $ = Fn.$
end
