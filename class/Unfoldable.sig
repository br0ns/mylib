signature UnfoldableCore = sig
  type 'a unfoldable_element
  type 'a unfoldable
  val write : ('a unfoldable_element, 'a unfoldable) writer
end

signature UnfoldableBase = sig
  include UnfoldableCore
  val empty : 'a unfoldable
end

signature UnfoldableExt = sig
  include UnfoldableCore

  val fromList : 'a unfoldable_element list -> 'a unfoldable
  val fromSeq : 'a unfoldable_element seq -> 'a unfoldable
  val fromVector : 'a unfoldable_element vector -> 'a unfoldable
  val fromStream : 'a unfoldable_element stream -> 'a unfoldable
  val fromSource : 'a unfoldable_element source -> 'a unfoldable
  val scan : ('a unfoldable_element, 'a unfoldable, 'x) scanner
end

signature Unfoldable = UnfoldableExt
