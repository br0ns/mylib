structure Either :> Either =
struct
datatype t = datatype either
exception Either

val swap = fn LEFT x => RIGHT x
            | RIGHT x => LEFT x

val ofLeft = fn LEFT x => x
              | _ => raise Either

val ofRight = fn RIGHT x => x
               | _ => raise Either

val ofEither = fn LEFT x  => x
                | RIGHT x => x

fun map (f, g) = fn LEFT x  => LEFT (f x)
                  | RIGHT x => RIGHT (g x)

fun either fs = ofEither o map fs

fun lefts es = List.mapPartial (fn LEFT x => SOME x | _ => NONE) es
fun rights es = List.mapPartial (fn RIGHT x => SOME x | _ => NONE) es

fun partition es =
    List.foldr (fn (LEFT x, (xs, ys))  => (x :: xs, ys)
                 | (RIGHT y, (xs, ys)) => (xs, y :: ys)
               ) (nil, nil) es

fun collate (cl, cr) =
 fn (LEFT x, LEFT y)   => cl (x, y)
  | (RIGHT x, RIGHT y) => cr (x, y)
  | (LEFT _, RIGHT _)  => LESS
  | (RIGHT _, LEFT _)  => GREATER

fun iso ((a2c, c2a), (b2d, d2b)) =
    (map (a2c, b2d), map (c2a, d2b))
end
