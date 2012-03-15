val fromList : 'a list -> 'a t
val fromSeq : 'a seq -> 'a t
val fromVector : 'a vector -> 'a t
val fromStream : 'a stream -> 'a t
val scan : ('a, 'a t, 'x) scanner
val scanWith : ('b, 'a, 'x) scanner -> ('b, 'a t, 'x) scanner
val unpack : ('a, 'a t) packed -> 'a t
val runPacker : ('a, 'b, 'a t) packer -> 'b -> 'a t
