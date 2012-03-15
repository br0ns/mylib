val plus : 'a t -> 'a t -> 'a t
val optional : 'a t -> 'a option t
val merger : 'a t list -> 'a t
val mergel : 'a t list -> 'a t
val guard : bool -> unit t
