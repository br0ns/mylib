val toList : 'a t -> 'a elm list
val toSeq : 'a t -> 'a elm seq
val toVector : 'a t -> 'a elm  vector
val toStream : 'a t -> 'a elm stream
val pack : ('a elm, 'a t, 'x) packer
val packWith : ('b, 'a elm, 'x) packer -> ('b, 'a t, 'x) packer
val runScanner : ('a elm, 'b, 'a t) scanner -> 'a t -> 'b option
