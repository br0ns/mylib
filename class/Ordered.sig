signature OrderedCore = sig
  type ordered
  val compare : ordered Cmp.t
end

signature OrderedBase = OrderedCore

signature OrderedExt = sig
  include OrderedCore

  val <   : ordered BinPred.t
  val <=  : ordered BinPred.t
  val >   : ordered BinPred.t
  val >=  : ordered BinPred.t
  val ==  : ordered BinPred.t
  val !=  : ordered BinPred.t
  val lt  : ordered BinPred.curried
  val lte : ordered BinPred.curried
  val gt  : ordered BinPred.curried
  val gte : ordered BinPred.curried
  val eq  : ordered BinPred.curried
  val neq : ordered BinPred.curried
  val min : ordered BinOp.t
  val max : ordered BinOp.t
  val comparing : ('a -> ordered) -> ordered Cmp.t
  val inRange : ordered * ordered -> ordered UnPred.t
end

signature Ordered = OrderedExt
