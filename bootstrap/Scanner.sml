structure Scanner =
struct
type ('a, 'b, 'x) t = ('a, 'x) Reader.t -> ('b, 'x) Reader.t
end
