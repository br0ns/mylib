structure String :> STRING =
struct
open String

fun foldl f b s =
    let
      val l = size s
      fun loop b n =
          if n = l then
            b
          else
            loop (f (sub (s, n), b)) (n + 1)
    in
      loop b 0
    end

fun foldr f b s =
    let
      fun loop b ~1 = b
        | loop b n = loop (f (sub (s, n), b)) (n - 1)
    in
      loop b (size s - 1)
    end
end
