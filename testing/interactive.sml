open (xrange) Int

val xs = [x + y |
          x <- xrange (100, 30, ~11)
        , y <- xrange (1, 50, 6)
        , y mod 12 <> 0
         ]

fun consAll x = map (fn xs => x :: xs)
fun concatMap f = List.concat o map f

fun permutations s =
    let
      fun weave x s =
          case s of
            nil => [[x]]
          | y :: s' => (x :: s) :: consAll y (weave x s')
      fun loop s =
          case s of
            nil    => [s]
          | x :: s => concatMap (weave x) (loop s)
    in
      loop s
    end
