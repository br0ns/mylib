fun genFoldr foldl f b xs =
    foldl (fn (x, k) => fn b => k (f (x, b))) (fn b => b) xs b

fun die s =
    (print ("An unexpected error occured in MyLib.\n\
            \Please email me at mortenbp@gmail.com.\n\
            \\n\
            \Error message:\n\
            \" ^ s
           )
   ; OS.Process.exit OS.Process.failure
    )

infixr $
fun f $ x = f x

fun const k _ = k
