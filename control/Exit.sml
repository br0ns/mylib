structure Exit :> Exit =
struct
type 'a t = 'a -> exn

fun block b : 'a =
    let
      exception E of 'a
    in
      b E handle E x => x
    end

fun e <- x = raise e x
end
