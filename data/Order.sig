signature Order = sig
  type t = order

  val swap : t UnOp.t

  val isEqual : t UnPred.t
  val isGreater : t UnPred.t
  val isLess : t UnPred.t
(* Ordered, Pickler, Unpickler *)
end
