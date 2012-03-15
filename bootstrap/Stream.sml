structure Stream =
struct
infix <|

val F = Lazy.force
val E = Lazy.eager

datatype 'a t' = Cons of 'a * 'a t
               | Nil
withtype 'a t = 'a t' Lazy.t

fun genEmpty () = E Nil

fun x <| xs = E (Cons (x, xs))

fun viewl xs =
    case F xs of
      Cons x => ViewL.<:: x
    | Nil    => ViewL.nill

fun getl xs =
    case F xs of
      Cons (x, xs) => SOME (x, xs)
    | Nil          => NONE
end
