signature MonadCore = sig
  type 'a monad
  val >>= : 'a monad * ('a -> 'b monad) -> 'b monad
end

signature MonadBase = sig
  include PointedCore
  include MonadCore
  sharing type pointed = monad
end

signature MonadExt = sig
  include MonadCore

  val join : 'a monad monad -> 'a monad
  val -- : 'a monad * 'b monad -> ('a * 'b) monad
  val mapM : ('a -> 'b monad) -> 'a list -> 'b list monad
  val mapMPartial : ('a -> 'b option monad) -> 'a list -> 'b list monad
  val mapM' : ('a -> '_ monad) -> 'a list -> unit monad
  val seq : 'a monad list -> 'a list monad
  val seq' : '_ monad list -> unit monad
  val =<< : ('a -> 'b monad) * 'a monad -> 'b monad
  val >=> : ('a -> 'b monad) * ('b -> 'c monad) -> 'a -> 'c monad
  val <=< : ('b -> 'c monad) * ('a -> 'b monad) -> 'a -> 'c monad
  val forever : 'a monad -> 'b monad
  val foreverWithDelay : int -> 'a monad -> 'b monad
  val ignore : '_ monad -> unit monad
  val keepM : ('a -> bool monad) -> 'a list -> 'a list monad
  val rejectM : ('a -> bool monad) -> 'a list -> 'a list monad
  val mapAndUnzipM : ('a -> ('b * 'c) monad) -> 'a list ->
                     ('b list * 'c list) monad
  val zipWithM : ('a * 'b -> 'c monad) -> 'a list * 'b list -> 'c list monad
  val zipWithM' : ('a * 'b -> '_ monad) -> 'a list * 'b list -> unit monad
  val foldM : ('a * 'b -> 'b monad) -> 'b -> 'a list -> 'b monad
  val foldM' : ('a * 'b -> 'b monad) -> 'b -> 'a list -> unit monad
  val tabulateM : int -> (int -> 'a monad) -> 'a list monad
  val tabulateM' : int -> (int -> '_ monad) -> unit monad
  val when : bool -> unit monad -> unit monad
  val unless : bool -> unit monad -> unit monad
end

signature Monad = sig
  include App
  include MonadExt
  sharing type app = monad
end
