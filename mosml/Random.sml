(* Implementation of SML/NJ's Random structure for Moscow ML *)

structure Random :> Random =
struct
open Random
type rand = generator
fun rand _ = newgen ()
fun toString _ = "[Random number generator]"
fun fromString _ = newgen ()
val randReal = random
fun randRange (a, b) r =
    let
      val x = randReal r
      val a = real a
      val b = real b
    in
      trunc (x * (b - a) + a)
    end
val randInt = range (valOf Int.minInt, valOf Int.maxInt)
val randNat = range (0, valOf Int.maxInt)
end
