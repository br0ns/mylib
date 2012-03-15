structure Fix :> Fix =
struct
  type 'a t = ('a -> 'a) -> 'a
end
