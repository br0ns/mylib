signature MapCore = sig
  type key
  type 'a entry = (key, 'a) product
  type 'a t
  datatype 'a viewl =
           nill
         | <:: of 'a entry * 'a t
  datatype 'a viewr =
           nilr
         | ::> of 'a t * 'a entry
  val empty : 'a t
  val null : 'a t unpred
  val singleton : 'a entry -> 'a t
  val <| : 'a entry * 'a t -> 'a t
  val >< : 'a t binop
  val !! : 'a t * key -> 'a
  val viewl : 'a t -> 'a viewl
  val viewr : 'a t -> 'a viewr
  val size : 'a t -> int
  val fromList : (key * 'a) list -> 'a t
  val delete : 'a t -> key -> 'a t
end

signature MapBase = sig
  include MapCore
  val foldl : ('a entry * 'b -> 'b) -> 'b -> 'a t -> 'b
  val foldr : ('a entry * 'b -> 'b) -> 'b -> 'a t -> 'b
end

signature MapExt = sig
  val insert : 'a t -> 'a entry -> 'a t
  val insertMaybe : 'a t -> 'a entry -> 'a t option
  val inDomain : 'a t -> key -> bool
  val inRange : ''a t -> ''a -> bool
  val domain : 'a t -> key list
  val range : 'a t -> 'a list
  val index : 'a t -> key -> 'a
  val adjust : 'a unop -> key -> 'a t -> 'a t
  val lookup : 'a t -> key -> 'a option
  val lookupWithDefault : 'a t -> key -> 'a -> 'a
  val lookupAdjust : 'a unop -> key -> 'a t -> 'a * 'a t
  val getItem : 'a t -> ('a entry * 'a t) option
  val getFirstItem : 'a t -> ('a entry * 'a t) option
  val getLastItem : 'a t -> ('a entry * 'a t) option
  val isoList : ('a t, (key * 'a) list) iso
  val toList : 'a t -> (key * 'a) list
  val toAscList : 'a t -> (key * 'a) list
  val toDecList : 'a t -> (key * 'a) list
  val collate : 'a cmp -> 'a t cmp
  val splitOn : key -> 'a t -> 'a t * 'a option * 'a t
  val alter : 'a t -> 'a option unop -> key -> 'a t unop

  (* Return a map whose domain is the union of the domains of the two input
   * maps, always choosing the second map on elements that are in bot domains.
   *)
  val plus : 'a t -> 'a t -> 'a t

  (* returns a map whose domain is the difference of the domains of the two
   * input maps
   *)
  val diff : 'a t -> 'a t -> 'a t
  val \ : 'a t binop

  (* Both with and without key
   *)
  val insertWith : 'a t -> 'a binop -> 'a entry -> 'a t
  val keep : 'a unpred -> 'a t unop
  val reject : 'a unpred -> 'a t unop
  val partition : 'a unpred -> 'a t -> 'a t * 'a t
  val mapPartial : ('a -> 'a option) -> 'a t unop
  val mapAccuml : ('a -> 'a * 'b) -> 'b -> 'a t -> 'b * 'a t
  val mapAccumr : ('a -> 'a * 'b) -> 'b -> 'a t -> 'b * 'a t
  val mapPartialAccuml :
      ('a * 'b -> 'a option * 'b) -> 'b -> 'a t -> 'b * 'a t
  val mapPartialAccumr :
      ('a * 'b -> 'a option * 'b) -> 'b -> 'a t -> 'b * 'a t
  val split : ('a -> ('b, 'c) sum) -> 'a t -> 'b t * 'c t
  val first : 'a t -> 'a
  val last : 'a t -> 'a
  val some : 'a t -> 'a
  val submapBy : 'a binpred -> 'a t binpred
  val properSubmapBy : 'a binpred -> 'a t binpred
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

  structure WithKey : sig
    (* Functor *)
    val map
    val app : 'a effect -> 'a func effect
    val --> : 'a func * ('a -> 'b) -> 'b func
    val <-- : ('a -> 'b) * 'a func -> 'b func
    val $$ : ('a -> 'b) * 'a func -> 'b func
    val lift : ('a -> 'b) -> 'a func -> 'b func
    val $| : 'a * 'b func -> 'a func

    (* Foldable *)
    val foldl : ('a entry * 'b -> 'b) -> 'b -> 'a t -> 'b
    val foldr : ('a entry * 'b -> 'b) -> 'b -> 'a t -> 'b
    val foldr1 : 'a binop -> 'a foldable -> 'a option
    val foldl1 : 'a binop -> 'a foldable -> 'a option
    val foldrUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
    val foldlUntil : ('a * 'b -> 'b * bool) -> 'b -> 'a foldable -> 'b
    val appl : 'a effect -> 'a foldable effect
    val appr : 'a effect -> 'a foldable effect
    val applUntil : ('a -> bool) -> 'a foldable effect
    val apprUntil : ('a -> bool) -> 'a foldable effect
    val concatList : 'a foldable list -> 'a list
    val any : 'a unpred -> 'a foldable unpred
    val all : 'a unpred -> 'a foldable unpred
    val find : 'a unpred -> 'a foldable -> 'a option
    val findr : 'a unpred -> 'a foldable -> 'a option
    val findl : 'a unpred -> 'a foldable -> 'a option
    val member : ''a -> ''a foldable unpred
    val notMember : ''a -> ''a foldable unpred
    val maximumBy : 'a cmp -> 'a foldable -> 'a option
    val minimumBy : 'a cmp -> 'a foldable -> 'a option
    val intSum : int foldable -> int
    val realSum : real foldable -> real
    val intProduct : int foldable -> int
    val realProduct : real foldable -> real
    val leftmost  : 'a option foldable -> 'a option
    val rightmost : 'a option foldable -> 'a option

    (* Both with and without key *)
    val insertWith : 'a t -> (('a * 'a) entry -> 'a) -> 'a entry -> 'a t
    val keep : 'a entry unpred -> 'a t unop
    val reject : 'a entry unpred -> 'a t unop
    val partition : 'a entry unpred -> 'a t -> 'a t * 'a t
    val mapPartial : ('a entry -> 'a option) -> 'a t unop
    val mapAccuml : ('a entry -> 'a * 'b) -> 'b -> 'a t -> 'b * 'a t
    val mapAccumr : ('a entry -> 'a * 'b) -> 'b -> 'a t -> 'b * 'a t
    val mapPartialAccuml :
        ('a entry * 'b -> 'a option * 'b) -> 'b -> 'a t -> 'b * 'a t
    val mapPartialAccumr :
        ('a entry * 'b -> 'a option * 'b) -> 'b -> 'a t -> 'b * 'a t
    val split : ('a entry -> ('b, 'c) sum) -> 'a t -> 'b t * 'c t
    val union : (('a * 'a) entry -> 'a) -> 'a t binop
    val unions : (('a * 'a) entry -> 'a) -> 'a t list -> 'a t
    val inter : (('a * 'b) entry -> 'c) -> 'a t * 'b t -> 'c t
    val inters : (('a * 'a) entry -> 'a) -> 'a t list -> 'a t
    val merge : (('a option * 'b option) entry -> 'c option) -> 'a t * 'b t -> 'c t
    val merges : 'a entry option binop -> 'a t list -> 'a t
    val first : 'a t -> 'a entry
    val last : 'a t -> 'a entry
    val some : 'a t -> 'a entry
    val submapBy : 'a entry binpred -> 'a t binpred
    val properSubmapBy : 'a entry binpred -> 'a t binpred
  end
end

signature Map = sig
  include Functor
  include Foldable
  include MapExt
  sharing type functor = foldable = t
end
