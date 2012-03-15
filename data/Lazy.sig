(* Memoized lazy evaluation *)
signature Lazy =
sig
  type 'a t

  val lazy : 'a Thunk.t -> 'a t
  val force : 'a t -> 'a
  val eager : 'a -> 'a t
  val delay : 'a t Thunk.t -> 'a t
  val thunk : 'a t -> 'a Thunk.t
  val memoise : 'a Thunk.t UnOp.t
end
