functor MonadP (MP : MonadPBase) : MonadP =
struct
structure M = Monad (MP)
structure A = Alt (open M MP)
open M A MP

fun mapPartial f m =
    m >>= (fn x => case f x of
                     SOME y => return y
                   | NONE   => genZero ()
          )
end
