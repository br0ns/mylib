signature Packer =
sig
type ('a, 'x) writer = 'a -> 'x -> 'x
type ('a, 'b, 'x) packer = ('a, 'x) writer ->
'b -> ('a -> 'x -> 'x) ->

(* this type for combining packers *)
type ('a, 'b, 'x) t = ('a, 'b, 'x) packer
(* this type in many use cases *)
type ('a, 'x) data = ('a, (), 'x) packer

val >>= : ('a, (), 'x) t * (() -> ('a, (), 'x) t) -> ('a, (), 'x) t
(* not return -- this is not your usual monad *)

fun (m >>= k) write ((), s) =
    k () write $ m write ()

'b -> ('a, 'x) writer -> 'x -> 'x

'b -> ('a * 'x -> 'x) -> 'x -> 'x

Word8Vector.runPacker packer
Word8Vector.runPacker : (word8, (), 'x) packer -> vector

val data =
    Word8Vector.pack
    do Binary.pack "III" [1, 2, 3]
     ; Word8Vector.fromString "foobar"
    end

end
