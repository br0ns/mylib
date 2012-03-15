signature Writer = sig
  type ('a, 'x) t = ('a, 'x) writer

  val >>= : ('x -> 'x) * (unit -> 'x -> 'x) -> 'x -> 'x
  (* Dummy `return' to get that nice do-notation *)
  val return : unit -> 'x -> 'x

  val mapStream : ('x, 'y) iso -> ('a, 'x) t -> ('a, 'y) t
  val map : ('a -> 'b) -> ('a, 'x) t -> ('b, 'x) t
end
