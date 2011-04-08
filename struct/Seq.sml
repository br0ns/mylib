structure Seq :> Seq =
struct
local
  structure X = Sequence(Seq)
in
open X Seq
end

(* Faster native implementations *)
fun head xs =
    case xs of
      E => raise Empty
    | S x => x
    | D (_, x :: _, _, _) => x
    | _ => die "Seq.head: empty prefix"

fun last xs =
    case xs of
      E => raise Empty
    | S x => x
    | D (_, _, _, x :: _) => x
    | _ => die "Seq.last: empty suffix"

end
