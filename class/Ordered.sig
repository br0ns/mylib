signature OrderedCore = sig
  type ordered
  val compare : ordered cmp
end

signature OrderedBase = OrderedCore

signature OrderedExt = sig
  include OrderedCore

  val <   : ordered binpred
  val <=  : ordered binpred
  val >   : ordered binpred
  val >=  : ordered binpred
  val ==  : ordered binpred
  val !=  : ordered binpred
  val lt  : ordered -> ordered -> bool
  val lte : ordered -> ordered -> bool
  val gt  : ordered -> ordered -> bool
  val gte : ordered -> ordered -> bool
  val eq  : ordered -> ordered -> bool
  val neq : ordered -> ordered -> bool
  val min : ordered binop
  val max : ordered binop
  val comparing : ('a -> ordered) -> 'a cmp
  val inRange : ordered * ordered -> ordered unpred

  structure Map : OrderedMap where key = ordered
  structure Set : OrderesSet where element = ordered
end

signature Ordered = OrderedExt
