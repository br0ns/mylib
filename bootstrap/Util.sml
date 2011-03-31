infixr $
fun f $ x = f x
fun curry f a b = f (a, b)
fun uncurry f (a, b) = f a b
fun flip f (a, b) = f (b, a)
fun id x = x
fun const x _ = x
fun die s =
    (print ("An unexpected error occured in MyLib.\n\
            \Please email me at mortenbp@gmail.com.\n\
            \\n\
            \Error message:\n\
            \" ^ s)
   ; OS.Process.exit (1))
