structure Source =
struct
type 'a t = unit -> 'a option
fun create read s =
    let
      val sr = ref s
      fun loop () =
          case read (!sr) of
            NONE => NONE
          | SOME (x, s) =>
            (sr := s ; SOME x)
    in
      loop
    end

fun get s = s ()
end
