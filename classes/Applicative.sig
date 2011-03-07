signature ApplicativeI = sig
  type 'a t
  val pure : 'a -> 'a t
  val ** : ('a -> 'b) t * 'a t -> 'b t
end

signature ApplicativeO = sig
  include ApplicativeI

  val |* : 'a t * 'b t -> 'b t
  val *| : 'a t * 'b t -> 'a t
  val $$ : ('a -> 'b) * 'a t -> 'b t
  val $| : 'a * 'b t -> 'a t
  val allPairs : 'a t -> 'b t -> ('a * 'b) t
  val liftA : ('a -> 'r) -> 'a t -> 'r t
  val liftA2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
  val liftA3 : ('a -> 'b -> 'c -> 'r) -> 'a t -> 'b t -> 'c t -> 'r t
  val liftA4 : ('a -> 'b -> 'c -> 'd -> 'r) -> 'a t -> 'b t -> 'c t -> 'd t-> 'r t
end

signature Applicative = sig
  include Functor
  structure Applicative : ApplicativeI
  sharing type Functor.t = Applicative.t
end
