signature SequenceCore = sig
  type 'a sequence
  val <| : 'a * 'a sequence -> 'a sequence
  val |> : 'a sequence * 'a -> 'a sequence
  val >< : 'a sequence binop
  val empty : 'a sequence
  val null : 'a sequence unpred
  val singleton : 'a -> 'a sequence
  val rev : 'a sequence unop
  val getl : ('a, 'a sequence) reader
  val getr : ('a, 'a sequence) reader
  val index : int -> 'a sequence -> 'a
  val adjust : 'a unop -> int -> 'a sequence unop
  val length : 'a sequence -> int
  val splitAt : int -> 'a sequence -> 'a sequence * 'a * 'a sequence
end

signature SequenceBase = sig
  include SequenceCore
  val foldr : ('a * 'b -> 'b) -> 'b -> 'a sequence -> 'c
  val foldl : ('a * 'b -> 'b) -> 'b -> 'a sequence -> 'c
  val map : ('a -> 'b) -> 'a sequence -> 'b sequence
end

signature SequenceExt = sig
  include SequenceCore

  val sort : a
  val shuffle : a
  val allPairs : a
  val allSplits : a
  val consAll : a
  val concatMap : a
  val range : a
  val group : a
  val power : a

  (* (Parts of) the SML List interface *)
  val head : 'a list -> 'a
  val tail : 'a list -> 'a list
  val last : 'a list -> 'a
  val init : 'a list -> 'a list
  val take : 'a list * int -> 'a list
  val drop : 'a list * int -> 'a list
  val rev : 'a list -> 'a list
  val concat : 'a list list -> 'a list
  val revAppend : 'a list * 'a list -> 'a list
  val app : ('a -> unit) -> 'a list -> unit
  val mapPartial : ('a -> 'b option) -> 'a list -> 'b list
  val partition : ('a -> bool)
                  -> 'a list -> 'a list * 'a list
  val tabulate : int * (int -> 'a) -> 'a list
  val collate : ('a * 'a -> order)
                -> 'a list * 'a list -> order

  (* (Parts of) the Haskell List interface *)
  val intersperse
  val intercalate
  val transpose
  val permutations
  val scanl
  val scanl1
  val scanlUntil
  val scanr
  val scanr1
  val scanrUntil


  val singleton : 'a -> 'a sequence
  val !! : 'a sequence * int -> 'a
  val append : 'a sequence -> 'a sequence

  val viewl : 'a sequence -> ('a, 'a sequence) viewl
  val viewr : 'a sequence -> ('a, 'a sequence) viewr
  val read : ('a, 'a sequence) reader
  val write : ('a, 'a sequence) writer

  val cons : 'a -> 'a sequence unop
  val snoc : 'a -> 'a sequence unop
  val adjust : 'a unop -> int -> 'a sequence unop
  val index : 'a sequence -> int -> 'a
  val lookup : 'a sequence -> int -> 'a option
  val insert : 'a sequence -> int -> 'a -> 'a sequence
end

signature Seq = sig
  include MonadP
  include Foldable
  include Enumerable where type 'a element = 'a
  include SeqExt
  sharing type monad = foldable = serialisable = sequence

  (* include Scannable where type scannable = char sequence *)
  (* include Nacsable where type nacsable = string sequence *)
end
