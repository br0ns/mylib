signature Bool =
sig
  include BOOL
type t = bool

  val isTrue : t UnPred.t
  val isFalse : t UnPred.t
(* Ordered, Pickler, Unpickler *)
end
