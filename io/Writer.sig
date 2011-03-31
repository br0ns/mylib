signature Writer = sig
  type ('a, 'x) t = ('a * 'x) -> 'x

  val mapStream : ('x, 'y) iso -> ('a, 'x) t -> ('a, 'y) t
  val map : ('a -> 'b) -> ('a, 'x) t -> ('b, 'x) t
end
