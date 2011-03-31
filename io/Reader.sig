signature Reader = sig
  type ('a, 'x) t = 'x -> ('a * 'x) option

  val mapStream : ('x, 'y) iso -> ('a, 'x) t -> ('a, 'y) t

  structure Monad : sig
    include MonadP
    val run : ('a monad -> 'b monad) -> ('a, 'x) t -> ('b, 'x) t
  end
end
