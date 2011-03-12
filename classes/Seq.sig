signature SeqCore = sig
  type 'a seq
  datatype 'a viewl =
           nill
         | <:: of 'a * 'a seq
  datatype 'a viewr =
           nilr
         | ::> of 'a * 'a seq
  val empty : 'a seq
  val <| : 'a * 'a seq -> 'a seq
  val |> : 'a seq * 'a -> 'a seq
  val >< : 'a seq BinOp.t
  val viewl : 'a seq -> 'a viewl
  val viewr : 'a seq -> 'a viewr
  val length : 'a seq -> int
  val index : 'a seq -> int -> 'a
  val adjust : 'a UnOp.t -> int -> 'a seq -> 'a seq
end

signature SeqBase = sig
  include Func
  include Foldable
  include SeqCore
  sharing type func = foldable = seq
end

signature SeqExt = sig
  include SeqCore

  val singleton : 'a -> 'a seq
end

signature Seq = sig
  include MonadP
  include Foldable
  include SeqExt
  sharing type monad = foldable = seq
end
