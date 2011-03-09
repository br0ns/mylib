signature AlternativeI = sig
  type 'a t
  val || : 'a t * 'a t -> 'a t
  val zero : 'a t
end

signature AlternativeO = sig
  include AlternativeI

  val optional : 'a t -> 'a option t
  val merge : 'a t list -> 'a t
  val guard : bool -> unit t
end

signature Alternative = sig
  include Applicative
  structure Alternative : AlternativeI
  sharing type Applicative.t = Alternative.t
end
