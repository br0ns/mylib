  val singleton : key * 'a -> 'a t
  val <| : key * 'a * 'a t -> 'a t
  val >< : 'a t binop
  val !! : 'a t * key -> 'a
  val viewl : 'a t -> (key * 'a, 'a t) viewl
  val viewr : 'a t -> (key * 'a, 'a t) viewr
  val fromList : (key * 'a) list -> 'a t
  val toList : 'a t -> (key * 'a) list
  val insert : 'a t -> key * 'a -> 'a t
  val insertMaybe : 'a t -> key * 'a -> 'a t option
  val inDomain : 'a t -> key -> bool
  val inRange : ''a t -> ''a -> bool
  val domain : 'a t -> key list
  val range : 'a t -> 'a list
  val index : 'a t -> key -> 'a
  val lookupWithDefault : 'a t -> key -> 'a -> 'a
  val lookupAdjust : ('a option -> 'a) -> key -> 'a t -> 'a * 'a t
  val split : 'a t -> ((key * 'a) * 'a t) option
  val splitFirst : 'a t -> ((key * 'a) * 'a t) option
  val splitLast : 'a t -> ((key * 'a)* 'a t) option
  val some : 'a t -> 'a
  val collate : 'a cmp -> 'a t cmp
  val splitOn : key -> 'a t -> 'a t * 'a option * 'a t

  (* Return a map whose domain is the union of the domains of the two input
   * maps, always choosing the second map on elements that are in bot domains.
   *)
  val plus : 'a t -> 'a t -> 'a t

  (* returns a map whose domain is the difference of the domains of the two
   * input maps
   *)
  val diff : 'a t -> 'a t -> 'a t
  val \ : 'a t binop

  val keep : 'a unpred -> 'a t unop
  val reject : 'a unpred -> 'a t unop
  val partition : 'a unpred -> 'a t -> 'a t * 'a t
  val partitionWith : ('a -> ('b, 'c) either) -> 'a t -> 'b t * 'c t
  val mapPartial : ('a -> 'a option) -> 'a t unop

  (* return a map whose domain is the union of the domains of the two input
   * maps, using the supplied function to define the map on elements that
   * are in both domains.
   *)
  val union : 'a binop -> 'a t binop
  val unions : 'a binop -> 'a t list -> 'a t

  (* return a map whose domain is the intersection of the domains of the
   * two input maps, using the supplied function to define the range.
   *)
  val inter : ('a * 'b -> 'c) -> 'a t * 'b t -> 'c t
  val inters : 'a binop -> 'a t list -> 'a t

  (* merge two maps using the given function to control the merge. For
   * each key k in the union of the two maps domains, the function
   * is applied to the image of the key under the map.  If the function
   * returns SOME y, then (k, y) is added to the resulting map.
   *)
  val merge : ('a option * 'b option -> 'c option) -> 'a t * 'b t -> 'c t
  val merges : 'a option binop -> 'a t list -> 'a t
