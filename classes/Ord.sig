signature OrdI = sig
  type t
  val compare : t * t -> order
end

signature Ord = sig
  structure Ord : OrdI
end

signature OrdO = sig
  include OrdI

  val < : t * t -> bool
  val <= : t * t -> bool
  val > : t * t -> bool
  val >= : t * t -> bool
  val == : t * t -> bool
  val <> : t * t -> bool
  val lt : t -> t -> bool
  val lte : t -> t -> bool
  val gt : t -> t -> bool
  val gte : t -> t -> bool
  val eq : t -> t -> bool
  val neq : t -> t -> bool
  val min : t -> t -> t
  val max : t -> t -> t
  val comparing : ('a -> t) -> 'a * 'a -> order
end
