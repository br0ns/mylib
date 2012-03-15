signature STRING =
sig
  include STRING
          where type string = string
            and type char = char

val foldl : (char * 'a -> 'a) -> 'a -> string -> 'a
val foldr : (char * 'a -> 'a) -> 'a -> string -> 'a
end
