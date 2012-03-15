val fromList : elm list -> t
val fromSeq : elm seq -> t
val fromVector : elm vector -> t
val fromStream : elm stream -> t
val scan : (elm, t, 'x) scanner
val unpack : (elm, t) packed -> t
val runPacker : (elm, 'b, t) packer -> 'b -> t
