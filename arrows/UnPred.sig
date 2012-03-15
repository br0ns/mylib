signature UnPred =
sig
  type 'a t = 'a -> bool

  val lift : ('a -> 'b) -> 'b t -> 'a t
  val both : 'a t binop
  val either : 'a t binop
  val xor : 'a t binop
  val any : 'a t list -> 'a t
  val all : 'a t list -> 'a t
  val neg : 'a t unop
end
