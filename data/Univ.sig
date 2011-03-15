signature Univ = sig
  type t
  exception Univ
  val newIso : ('a, t) iso thunk
  val newEmb : ('a, t) emb thunk
end
