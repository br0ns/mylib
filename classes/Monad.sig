signature MonadI = sig
  type 'a t
  val >>= : 'a t * ('a -> 'b t) -> 'b t
end

signature MonadO = sig
  include MonadI

  val join : 'a t t -> 'a t
  val >> : 'a t * 'b t -> 'b t
  (* val << : 'a t * 'b t -> 'a t *)
  (* val -- : 'a t * 'b t -> ('a * 'b) t *)
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
end

signature Monad = sig
  include Pointed
  structure Monad : MonadI
  sharing type Pointed.t = Monad.t
end
