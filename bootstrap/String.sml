structure String =
struct
open String
type t = string

fun foldl f b s =
    let
      val l = size s
      fun loop n b =
          if Int.>= (n, l)
          then b
          else loop (n + 1) (f (String.sub(s, n), b))
    in
      loop 0 b
    end

fun foldr f b s =
    let
      fun loop ~1 b = b
        | loop n b = loop (n - 1) (f (String.sub(s, n), b))
    in
      loop (size s - 1) b
    end
end
