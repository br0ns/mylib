structure Stream =
struct
infix <| ><

datatype 'a t = Promise of 'a t Lazy.t
              | Cons of 'a * 'a t
              | Nil
(* datatype 'a t_ = Cons of 'a * 'a t *)
(*                | Nil *)
(* withtype 'a t = 'a t_ Lazy.t *)

val empty = Nil

fun x <| xs = Cons (x, xs)

fun getl xs =
    case xs of
      Nil => NONE
    | Cons (x, xs) => SOME (x, xs)
    | Promise p => getl $ Lazy.force p

fun foldl f b xs =
    case xs of
      Nil => b
    | Cons (x, xs) => foldl f (f (x, b)) xs
    | Promise p => foldl f b $ Lazy.force p

fun foldr f b xs = foldl (fn (x, k) => fn b => k (f (x, b))) (fn b => b) xs b

end
