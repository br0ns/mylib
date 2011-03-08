functor Applicative
        (include Applicative
        ) :>
        ApplicativeO where type 'a t = 'a Applicative.t
=
struct
open Pointed Applicative infix ** |* *| $$

fun map2 f a b = return f ** a ** b
fun map3 f a b c = return f ** a ** b ** c
fun map4 f a b c d = return f ** a ** b ** c ** d
fun a |* b = map2 (fn _ => fn x => x) a b
fun a *| b = map2 (fn x => fn _ => x) a b
fun allPairs a b = map2 (fn x => fn y => (x, y)) a b
end


functor ApplicativeEtAl (X : Applicative) =
struct
local
  open X.Pointed X.Applicative infix **

  structure Y = struct
  structure Functor = struct
  type 'a t = 'a t
  fun map f xs = return f ** xs
  end
  end

  structure F = Functor (Y)
  structure P = Pointed (X)
  structure A = Applicative (X)
in
open F P A Y
end

end

(* local *)
(*   structure A = Applicative (X) *)
(*   structure P = Pointed (X) *)
(* in *)
(* open A P X infix ** *)
(* end *)

(* local *)
(*   structure X = struct *)
(*   structure Functor = struct *)
(*   type 'a t = 'a t *)
(*   fun map f xs = return f ** xs *)
(*   end *)
(*   end *)
(*   structure F = Functor (X) *)
(* in *)
(* open F X *)
(* end *)

(* end *)
