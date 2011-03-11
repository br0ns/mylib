signature OrderedBase = sig
  type '_ t
  val compare : '_ t * '__ t -> order
end

signature Compare = sig
  structure Compare : CompareI
end

signature CompareO = sig
  include CompareI

  val <   : '_ t * '__ t -> bool
  val <=  : '_ t * '__ t -> bool
  val >   : '_ t * '__ t -> bool
  val >=  : '_ t * '__ t -> bool
  val ==  : '_ t * '__ t -> bool
  val !=  : '_ t * '__ t -> bool
  val lt  : '_ t -> '__ t -> bool
  val lte : '_ t -> '__ t -> bool
  val gt  : '_ t -> '__ t -> bool
  val gte : '_ t -> '__ t -> bool
  val eq  : '_ t -> '__ t -> bool
  val neq : '_ t -> '__ t -> bool
  val min : 'a t * 'a t -> 'a t
  val max : 'a t * 'a t -> 'a t
  val comparing : ('a -> '_ t) -> 'a * 'a -> order
end
