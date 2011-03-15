signature SeqCore = sig
  type 'a t
  datatype 'a viewl =
           nill
         | <:: of 'a * 'a t
  datatype 'a viewr =
           nilr
         | ::> of 'a t * 'a
  val empty : 'a t
  val null : 'a t unpred
  val singleton : 'a -> 'a t
  val <| : 'a * 'a t -> 'a t
  val |> : 'a t * 'a -> 'a t
  val >< : 'a t binop
  val viewl : 'a t -> 'a viewl
  val viewr : 'a t -> 'a viewr
  val length : 'a t -> int
  val indexAdjust : 'a unop -> int -> 'a t -> 'a * 'a t
  val fromList : 'a list -> 'a t
end

signature SeqBase = sig
  include SeqCore
  val map : ('a -> 'b) -> 'a t -> 'b t
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b
end

signature SeqExt = sig
  include SeqCore
  val !! : 'a t * int -> 'a
  val cons : 'a -> 'a t unop
  val snoc : 'a -> 'a t unop
  val getItem : 'a t -> ('a * 'a t) option
  val isoList : ('a t, 'a list) iso
  val toList : 'a t -> 'a list
  val adjust : 'a unop -> int -> 'a t unop
  val index : 'a t -> int -> 'a
  val lookup : 'a t -> int -> 'a option
  val insert : 'a t -> int -> 'a -> 'a t
end

signature Seq = sig
  include MonadP
  include Foldable
  include SeqExt
  sharing type monad = foldable = t
end
