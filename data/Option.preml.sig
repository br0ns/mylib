signature Option =
sig
  include OPTION where type 'a option = 'a option
  include MonadP where type 'a t = 'a option
val reflect : Exn.t -> 'a t -> 'a
end