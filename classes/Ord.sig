signature OrdI = sig
  type t
  val compare : t * t -> order
end

signature Ord = sig
  structure Ord : OrdI
end
