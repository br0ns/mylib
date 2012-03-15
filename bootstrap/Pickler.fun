structure Nacser =
struct
type ('a, 'b, 'x) t = ('a, 'x) Writer.t -> ('b, 'x) Writer.t
end
