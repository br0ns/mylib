signature Option =
sig
  include OPTION where type 'a option = 'a option
  include MonadP where type 'a t = 'a option
val reflect : exn -> 'a t -> 'a
val maybe : 'b -> ('a -> 'b) -> 'a t -> 'b
val fromOption : 'a -> 'a t -> 'a
(* alias for 'valOf' *)
val ofSome : 'a t -> 'a
end
