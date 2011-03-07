signature TraversableI = sig
  type 'a t
  val travr : ('b * 'a -> 'c * 'a) -> 'a -> 'b t -> 'a * 'c t
end

signature TraversableO = sig
  include TraversableI

  val travl : ('b * 'a -> 'c * 'a) -> 'a -> 'b t -> 'a * 'c t
  val maplUntil : ('a -> 'a * bool) -> 'a t -> 'a t
  val maprUntil : ('a -> 'a * bool) -> 'a t -> 'a t
end

signature Traversable = sig
  structure Traversable : TraversableI
end
