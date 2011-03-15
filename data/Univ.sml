structure Univ :> Univ =
struct
type t = exn
exception Univ

fun newIso () : ('a, t) iso =
    let
      exception E of 'a
      fun ofE (E x) = x
        | ofE _ = raise Univ
    in
      {to = E, from = ofE}
    end

fun newEmb () : ('a, t) emb =
    let
      exception E of 'a
      fun ofE (E x) = SOME x
        | ofE _ = NONE
    in
      {to = E, from = ofE}
    end
end
