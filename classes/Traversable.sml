functor Traversable
        (include Traversable
         ) :>
        TraversableO where type 'a t = 'a Traversable.t
=
struct
open Traversable

fun travl f b xs =
    let
      fun g (x, c) =
          let
            
          c (f (x, b))
      fun id x = x
    in
      travr g id xs b
end

local
  fun mapUntil trav f xs =
      trav
        (fn (x, false) => (x, false)
          | (x, true) => f x
        )
        true
        xs
in
fun maprUntil f xs = mapUntil travr f xs
fun maplUntil f xs = mapUntil travl f xs
end
end

functor Traversable' (T : TraversableI) = Traversable (structure Traversable = T)

functor FoldableFromTraversable (T : TraversableI) :>
        FoldableI where type 'a t = 'a T.t
=
struct
open T
fun foldr f b xs =
    let
      val (b, _) =
          travr (fn (x, a) => (x, f (x, a))) b xs
    in
      b
    end
end

functor FuntorFromTraversable (T : TraversableI) :>
        FunctorI where type 'a t = 'a T.t
=
struct
open T
fun map f xs =
    let
      val (_, ys) =
          travr (fn (x, _) => (f x, ())) () xs
    in
      ys
    end
end
