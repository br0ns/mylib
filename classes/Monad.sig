signature MonadI = sig
  type 'a t
  val >>= : 'a t * ('a -> 'b t) -> 'b t
  val return : 'a -> 'a t
end

signature MonadO = sig
  include MonadI

  val >> : 'a t * 'b t -> 'b t
  val mapM : ('a -> 'b t) -> 'a list -> ('b list) t
  val mapM' : ('a -> 'b t) -> 'a list -> unit t
  val seq : 'a t list -> 'a list t
  val seq' : 'a t list -> unit t
  val =<< : ('a -> 'b t) * 'a t -> 'b t
  val >=> : ('a -> 'b t) * ('b -> 'c t) -> 'a -> 'c t
  val <=< : ('b -> 'c t) * ('a -> 'b t) -> 'a -> 'c t
  val forever : 'a t -> 'b t
  val foreverWithDelay : int -> 'a t -> 'b t
  val ignore : 'a t -> unit t
  val join : 'a t t -> 'a t
  val filterM : ('a -> bool t) -> 'a list -> 'a list t
  (* val mapAndUnzipM : ('a -> ('b * 'c) t) -> ('b list * 'c list) t *)
  (* val zipWithM : ('a * 'b -> 'c t) -> 'a list * 'b list -> 'c list t *)
  (* val zipWithM' : ('a * 'b -> 'c t) -> 'a list * 'b list -> unit t *)
  (* val foldM : ('a * 'b -> 'b t) -> 'b -> 'a list -> 'b t *)
  (* val foldM' : ('a * 'b -> 'b t) -> 'b -> 'a list -> unit t *)
  val tabulateM : int -> 'a t -> 'a list t
  val tabulateM' : int -> 'a t -> unit t
  val when : bool -> unit t -> unit t
  val unless : bool -> unit t -> unit t
  val liftM : ('a -> 'r) -> 'a t -> 'r t
  val liftM2 : ('a -> 'b -> 'r) -> 'a t -> 'b t -> 'r t
  val liftM3 : ('a -> 'b -> 'c -> 'r) -> 'a t -> 'b t -> 'c t -> 'r t
  val liftM4 : ('a -> 'b -> 'c -> 'd -> 'r) -> 'a t -> 'b t -> 'c t -> 'd t -> 'r t
  val ap : ('a -> 'b) t * 'a t -> 'b t
end

signature Monad = sig
  structure Monad : MonadI
end
