signature Fn =
sig
  type ('a, 'b) t = 'a -> 'b

  val curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
  val uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c
  val curry3 : ('a * 'b * 'c -> 'd) -> 'a -> 'b -> 'c -> 'd
  val uncurry3 : ('a -> 'b -> 'c -> 'd) -> 'a * 'b * 'c -> 'd
  val curry4 : ('a * 'b * 'c * 'd -> 'e) -> 'a -> 'b -> 'c -> 'd -> 'e
  val uncurry4 : ('a -> 'b -> 'c -> 'd -> 'e) -> 'a * 'b * 'c * 'd-> 'e

  val lift : ('c -> 'a) * ('b -> 'd) -> ('a -> 'b) -> 'c -> 'd
  val const : 'a -> ('b, 'a) t
  val eta : ('a -> 'b -> 'c) -> 'a -> 'b -> 'c
  val fix : ('a -> 'b) fix
  val repeat : int -> ('a -> 'a) -> 'a -> 'a
  val flip : ('a * 'b -> 'c) -> 'b * 'a -> 'c
  val flipc : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c
  val id : 'a -> 'a
  val ignore : 'a -> unit
  val seal : ('a -> 'b) -> 'a -> 'b thunk
  val first : ('a -> 'b) -> 'a * 'c -> 'b * 'c
  val second : ('a -> 'b) -> 'c * 'a -> 'c * 'b
  val o : ('b -> 'c) * ('a -> 'b) -> 'a -> 'c
  val <\ : 'a * ('a * 'b -> 'c) -> 'b -> 'c
  val \> : ('a -> 'b) * 'a -> 'b
  val </ : 'a * ('a -> 'b) -> 'b
  val /> : ('a * 'b -> 'c) * 'b -> 'a -> 'c
  val $ : ('a -> 'b) * 'a -> 'b
  val >- : 'a * ('a -> 'b) -> 'b
end
