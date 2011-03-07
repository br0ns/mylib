functor Functor
          (include Functor
          ) :>
        FunctorO where type 'a t = 'a Functor.t
=

struct
open Functor
fun app f fnc = (map f fnc ; ())
end

functor Functor' (F : FunctorI) = Functor (structure Functor = F)
