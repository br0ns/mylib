signature ApplicativeI = sig
  type 'a t
  val ** : ('a -> 'b) t * 'a t -> 'b t
end

signature ApplicativeO = sig
  include ApplicativeI

  val |* : 'a t * 'b t -> 'b t
  val *| : 'a t * 'b t -> 'a t
  val allPairs : 'a t -> 'b t -> ('a * 'b) t
  val map2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
  val map3 : ('a -> 'b -> 'c -> 'r) -> 'a t -> 'b t -> 'c t -> 'r t
  val map4 : ('a -> 'b -> 'c -> 'd -> 'r) -> 'a t -> 'b t -> 'c t -> 'd t-> 'r t
end

signature Applicative = sig
  include Pointed
  structure Applicative : ApplicativeI
  sharing type Pointed.t = Applicative.t
end
