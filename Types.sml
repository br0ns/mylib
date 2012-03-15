type substring = Substring.substring
type largeint = LargeInt.int
type time = Time.time
type word = Word.word
type word8 = Word8.word
type word16 = Word16.word
type word32 = Word32.word
datatype bit = Z | O
datatype endian = BIG | LITTLE
datatype radix = datatype StringCvt.radix

datatype viewl = datatype ViewL.t
datatype viewr = datatype ViewR.t
type ('a, 'b) iso = ('a -> 'b) * ('b -> 'a)
type ('a, 'b) emb = ('a -> 'b) * ('b -> 'a option)
type 'a effect = 'a -> unit
type 'a thunk = unit -> 'a
type 'a cmp = 'a * 'a -> order
type 'a unop = 'a -> 'a
type 'a binop = 'a * 'a -> 'a
type 'a unpred = 'a -> bool
type 'a binpred = 'a * 'a -> bool
type 'a fix = 'a unop -> 'a
type ('a, 'b) cont = ('a -> 'b) -> 'b
datatype ('a, 'b) either = LEFT of 'a | RIGHT of 'b
datatype ('a, 'b) product = & of 'a * 'b
type ('a, 'x) reader = 'x -> ('a * 'x) option
type ('a, 'x) writer = 'a -> 'x -> 'x
type ('a, 'b, 'x) scanner = ('a, 'x) reader -> ('b, 'x) reader
(* type ('a, 'b, 'x) packer = ('a, 'x) writer -> ('b, 'x) writer *)
type ('a, 'x) packed = ('a, 'x) writer -> 'x -> 'x
type ('a, 'b, 'x) packer = 'b -> ('a, 'x) packed

type ('a, 'x) binary = (word8, 'a, 'x) scanner * (word8, 'a, 'x) packer

type 'a lazy = 'a Lazy.t
type 'a seq = 'a Seq.t
type 'a stream = 'a Stream.t

type 'a vector = 'a Vector.vector
type 'a vectorslice = 'a VectorSlice.slice

type 'a array = 'a Array.array
type 'a arrayslice = 'a ArraySlice.slice

