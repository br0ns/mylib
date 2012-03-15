structure Reader =
struct
type ('a, 'x) t = 'x -> ('a * 'x) option
end
