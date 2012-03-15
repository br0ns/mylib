functor ListSetFn (O : Ordered) :>
        Set where type elm = O.ordered
=
struct structure PreML__TMP__AIKndOxNzt = 
     Ordered(O) open PreML__TMP__AIKndOxNzt infix == !=

type elm = O.ordered
type set = elm list

val empty = nil
fun member s x = List.exists (fn y => x == y) s

fun insert nil x = [x]
  | insert (y :: ys) x =
    case compare (x, y) of
      LESS    => x :: y :: ys
    | EQUAL   => y :: ys
    | GREATER => y :: insert ys x

val null = List.null
fun remove s x = if member s x then SOME (List.filter (fn y => y != x) s)
                 else NONE
val compareElm = compare

val foldl = foldl
end

functor ListSetFn (O : Ordered) = Set(ListSetFn(O))