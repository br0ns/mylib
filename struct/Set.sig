signature SetCore = sig
  type element
  type t
  datatype viewl =
           nill
         | <:: of element * t
  datatype viewr =
           nilr
         | ::> of t * element
  val empty : t
  val null : t unpred
  val singleton : element -> t
  val <| : element * t -> t
  val >< : t binop
  val member : t -> element unpred
  val viewl : t -> viewl
  val viewr : t -> viewr
  val size : t -> int
  val delete : t -> element -> t
end

signature SetBase = sig
  include SetCore
  val foldl : (element -> 'a) -> 'a -> t -> 'a
  val foldr : (element -> 'a) -> 'a -> t -> 'a
end

signature SetExt = sig
  val insert : t -> element -> t
  val insertMaybe : t -> element -> t option
  val memberAdjust : element unop -> element -> t -> t option
  val notMember : t -> element unpred
  val getItem : t -> (element * t) option
  val getFirstItem : t -> (element * t) option
  val getLastItem : t -> (element * t) option
  include Serialisable where type 'a element = element and 'a serialisable = t
  val toAscList : t -> element list
  val toDecList : t -> element list
  val splitOn : element -> t -> t * element option * t
  val first : t -> element
  val last : t -> element
  val some : t -> element

  val union : t -> t -> t
  val unions : t list -> t

  val inter : t -> t -> t
  val inters : t list -> t

  val diff : t -> t -> t
  val \ : t binop

  val insertWith : t -> element binop -> element -> t
  val keep : element unpred -> t unop
  val reject : element unpred -> t unop
  val partition : element unpred -> t -> t * t
  val mapPartial : (element -> element option) -> t unop
  val mapPartialAccuml :
      (element * 'a -> element option * 'a) -> 'a -> t -> element * t
  val mapPartialAccumr :
      (element * 'a -> element option * 'a) -> 'a -> t -> element * t
  val mapAccuml : (element -> element * 'a) -> 'b -> 'a t -> 'b * 'a t
  val mapAccumr : (element -> element * 'a) -> 'b -> 'a t -> 'b * 'a t
end

signature Set = sig
  include MonoMonadP
  include MonoFoldable
  include Ordered
  include SetExt
  sharing type monad = foldable = ordered = t

  include Serialisable where type 'a element = element
                       where type 'a serialisable = t
end
