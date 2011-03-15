functor Show
          (include Show
          ) :>
        ShowO where type 'a t = 'a Show.t
=
struct
open Show
fun println x = print (show x ^ "\n")
end
