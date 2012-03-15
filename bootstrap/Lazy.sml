structure Lazy =
struct
datatype 'a t_ = T of unit -> 'a t
               | V of 'a
               | E of exn
withtype 'a t = 'a t_ ref

fun delay t = ref (T t)
fun eager v = ref (V v)
fun force p =
    case !p of
      V v => v
    | E e => raise e
    | T t =>
      let
        val p' = t ()
      in
        p := !p'
      ; force p
      end
      handle e => (p := E e ; raise e)
fun lazy t = delay
                (fn _ =>
                    ref (V (t ()) handle e => E e)
                )

fun thunk p () = force p
fun memoise t = thunk (lazy t)
end
