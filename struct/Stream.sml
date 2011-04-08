structure Stream :> Stream =
struct
structure Base = struct
open Stream (* Datatype defined in bootstraping/Stream.sml *)

val empty = Lazy.eager N
fun null xs =
    case Lazy.force xs of
      Nil => true
    | _   => false

end
structure Seq = Sequence(Base)
open Seq Base

end
