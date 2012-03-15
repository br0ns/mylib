val toList : t -> elm list
val toSeq : t -> elm seq
val toVector : t -> elm vector
val toStream : t -> elm stream
val pack : (elm, t, 'x) packer
val runScanner : (elm, 'a, t) scanner -> t -> 'a option
