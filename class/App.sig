signature App = sig
  type 'a app
  val pure : 'a -> 'a app
  val ** : ('a -> 'b) app * 'a app -> 'b app
end

signature AppInstance = sig
  include App

  val |* : 'a t * 'b t -> 'b t
  val *| : 'a t * 'b t -> 'a t
  val -- : 'a t * 'b t -> ('a * 'b) t
  val cartesian : 'a t -> 'b t -> ('a * 'b) t
  val lift2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
  val lift3 : ('a -> 'b -> 'c -> 'r) -> 'a t -> 'b t -> 'c t -> 'r t
  val lift4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
              'a t -> 'b t -> 'c t -> 'd t -> 'r t
  val mergerBy : 'a binop -> 'a t list -> 'a t option
  val mergelBy : 'a binop -> 'a t list -> 'a t option
end
