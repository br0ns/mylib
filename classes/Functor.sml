functor Functor
          (include Functor
          ) :>
        FunctorO where type 'a t = 'a Functor.t
=

struct
open Functor infix $$ $|

val lift = map
fun app f fnc = (map (fn x => (f x ; ())) fnc ; ())
fun --> (fnc, f) = map f fnc
fun a $$ b = map a b
fun x $| a = (fn _ => x) $$ a
end
