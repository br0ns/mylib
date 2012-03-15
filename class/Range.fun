functor Range (R : Range) : RangeEX =
struct
open R

fun up (a, b, step) =
    case compare (a, b) of
      GREATER => nil
    | _       => a :: up (Fn.repeat step next a, b, step)

fun down (a, b, step) =
    case compare (a, b) of
      LESS => nil
    | _    => a :: down (Fn.repeat step prev a, b, step)

fun range (a, b) = up (a, b, 1)
fun xrange (a, b, step) =
    if step = 0
    then raise Domain
    else
      if step > 0
      then up (a, b, step)
      else down (a, b, ~step)
end
