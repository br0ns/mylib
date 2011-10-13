structure Array2 :> ARRAY2 =
struct
type 'a array = 'a Array.array Array.array

fun dimensions arr =
    case Array.length arr of
      0 => (0, 0)
    | n => (n, Array.length (Array.sub (arr, 0)))

fun sub (arr, x, y) =
    Array.sub (Array.sub (arr, x), y)
end
