structure Writer =
struct
type ('a, 'x) t = ('a, 'x) writer

fun (m >>= k) = k () o m
val return = Fn.const

fun mapStream (to, from) write x s =
    from $ write x $ to s

fun map f write x s = write (f x) s
end
