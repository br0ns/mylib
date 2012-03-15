signature Reader =
sig
  include MonadStateP where type 'a inner = 'a option

  val returnO : 'a option -> ('a, 'x) t
  val run : ('a, 'x) t -> 'x -> 'a

  (* Lightweight parser interface *)
  val fail : ('a, 'x) t
  (* TODO: the rest *)
end
