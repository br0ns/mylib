signature LazyList =
sig
  datatype 'a t' = Cons of 'a * 'a t' Lazy.t
                 | Nil
  type 'a t = 'a t' Lazy.t

  val eager : 'a List.list -> 'a t
  val force : 'a t -> 'a List.list
  (* Alias for getItem *)
  val split : 'a t -> ('a * 'a t) option
  val cons : 'a * 'a t -> 'a t
  val singleton : 'a -> 'a t

  (* Tabulate over the natural numbers (starting from zero) *)
  val tabulateN : (int -> 'a) -> 'a t

  (* These work just like for regular lists. So see
   * http://www.standardml.org/Basis/list.html
   *
   * Note: Since lazy list have the potential to be infinit these functions
   * can be hazardous: length, last, app, find, foldl, foldr, exists, all
   * (raising an exception can stop the evaluation of a (possibly infinit)
   * list).
   *
   * Note': The functions are generally as lazy as possible. Example: while
   * {take ([1], 2)} raises Subscript for regular lists {take (eager [1], 2)}
   * only raises Subscript if more than one element of the resulting lazy list
   * is ever consumed. *)
  val null : 'a t -> bool
  val length : 'a t -> int
  val @ : 'a t * 'a t -> 'a t
  val hd : 'a t -> 'a
  val tl : 'a t -> 'a t
  val last : 'a t -> 'a
  val getItem : 'a t -> ('a * 'a t) option
  val nth : 'a t * int -> 'a
  val take : 'a t * int -> 'a t
  val drop : 'a t * int -> 'a t
  val rev : 'a t -> 'a t
  val concat : 'a t t -> 'a t
  val revAppend : 'a t * 'a t -> 'a t
  val app : ('a -> unit) -> 'a t -> unit
  val map : ('a -> 'b) -> 'a t -> 'b t
  val mapPartial : ('a -> 'b option) -> 'a t -> 'b t
  val find : ('a -> bool) -> 'a t -> 'a option
  val filter : ('a -> bool) -> 'a t -> 'a t
  val partition : ('a -> bool) -> 'a t -> 'a t * 'a t
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
  val exists : ('a -> bool) -> 'a t -> bool
  val all : ('a -> bool) -> 'a t -> bool
  val tabulate : int * (int -> 'a) -> 'a t
  val collate : ('a * 'a -> order) -> 'a t * 'a t -> order
  val allPairs : 'a t -> 'b t -> ('a * 'b) t
end
