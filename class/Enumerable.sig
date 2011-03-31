signature EnumerableCore = sig
  type 'a enumerable_element
  type 'a enumerable
  val read : ('a enumerable_element, 'a enumerable) reader
end

signature EnumerableBase = EnumerableCore

signature EnumerableExt = sig
  include EnumerableCore

  val toList : 'a enumerable -> 'a enumerable_element list
  val toSeq : 'a enumerable -> 'a enumerable_element seq
  val toVector : 'a enumerable -> 'a enumerable_element vector
  val toStream : 'a enumerable -> 'a enumerable_element stream
  val toSource : 'a enumerable -> 'a enumerable_element source
  val nacs : ('a enumerable_element, 'a enumerable, 'x) nacser
end

signature Enumerable = EnumerableExt
