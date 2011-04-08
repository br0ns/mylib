fun println s = print (s ^ "\n")

signature List = sig
  include LIST
  include MonadPlus where type 'a Monad.t = 'a list
  include Foldable where type 'a Foldable.t = 'a list
  (* val sort : ('a -> 'a -> order) -> 'a list -> 'a list *)
  (* val shuffle : 'a list -> 'a list *)
  (* val splitAt : 'a list * int -> 'a list * 'a list *)
  (* val allSplits : 'a list -> ('a list * 'a list) list *)
  (* val consAll : 'a * 'a list list -> 'a list list *)
  (* val range : int -> int -> 'a list -> 'a list *)
  (* val power : 'a list -> 'a list list *)
  (* val group : ('a -> 'a -> bool) -> 'a list -> 'a list list *)
  (* val transpose : 'a list list -> 'a list list *)
end


structure List :> List =
struct with (MonadPlusEtAl, Foldable)
open List
type 'a t = 'a list

type 'a pointed = 'a t
fun return x = [x]

type 'a monad = 'a t
fun >>== (xs, f) = concat (map f xs)

type 'a alternative = 'a t
val zero = nil
val ||   = op@

type 'a folable = 'a t
val foldr = foldr
end


structure List :> List =
struct with (MonadPlusEtAl, Foldable)
open List

structure Pointed = struct
type 'a t = 'a list
fun return x = [x]
end

structure Monad = struct
type 'a t = 'a list
fun >>= (xs, f) = concat (map f xs)
end

structure Alternative = struct
type 'a t = 'a list
val zero = nil
val || = op@
end

structure Foldable = struct
type 'a t = 'a list
val foldr = foldr
end

end

extend List with (MonadPlusEtAl, Foldable)




structure List =
struct
local
  (* structure Fo = Foldable (List) *)
  (* structure T = Traversable (List) *)

  structure X = MonadPlusEtAl (List)

  (* structure MP = MonadPlus (List) *)
in
open X List
end
end

structure IntState = State (type state = int)
structure IntListState = StateTPlus (type state = int open List)

open List infix $$ **

structure IntMap = struct
type key = int
type 'a element = key * 'a
type 'a t = 'a element list

fun hasKey m k = List.exists (fn (k', _) => k = k') m
fun insert m (k, x) = if hasKey m k then m else (k, x) :: m
fun remove m k = List.filter (fn (k', _) => k <> k') m
fun update m (k, x) = (k, x) :: remove m k
end

(* structure List = Functor (List) *)
(* structure List = Monad (List) *)

(* val _ = List.app print ["foo", "bar", "baz"] *)

(* fun id x = x *)
fun curry f a b = f (a, b)

val x = (curry op+) $$ [1, 2] ** [2, 3]

(* val xs = List.liftM2 (curry id) [1, 2] [3, 4, 42] *)
(* local open List infix $$ ** *| |* $| in *)
(* val ys = [1,2] |* [3,4] *)
(* end *)
(* (\* val ys = List.msum [[1,2],[3,4]] *\) *)


(* fun prPair (a, b) = println ("(" ^ Int.toString a ^ ", " ^ Int.toString b ^ ")") *)
(* val _ = List.app prPair xs *)
(* val _ = List.app (println o Int.toString) ys *)


(* signature Set = sig *)
(*   type element *)
(*   type 'a t *)

(*   val empty : element t *)
(*   val insert : element t -> element -> element t *)
(*   val member : element t -> element -> bool *)
(* end *)

structure IntSet = struct
type 'a element = int
type 'a t = 'a list

val empty = nil
fun member s x = List.exists (fn y => y = x) s
fun insert s x = if member s x then s else x :: s
fun union s t = foldr (fn (x, s) => insert s x) s t
fun concat ss = foldr (fn (s, s') => union s s') empty ss

end
(* structure Monad = *)
(* Monad' ( *)
(* struct *)
(* type 'a t = 'a t *)
(* fun >>= (s, f) = concat (map f xs) *)
(* fun return x = insert empty x *)
(* end *)
(* ) *)

(* open Monad *)
(* end *)
