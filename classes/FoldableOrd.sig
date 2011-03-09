signature FoldableOrdO = sig
  include FoldableI

  val maximum : 'a t -> 'a e option
  val minimum : 'a t -> 'a e option
end

signature FoldableOrd = sig
  include Foldable
  include Ord
  sharing type Foldable.e = Ord.t
end
