structure Die =
struct
fun die s =
    (print ("An unexpected error occured in MyLib.\n\
            \Please email me at mortenbp@gmail.com.\n\
            \\n\
            \Error message:\n\
            \" ^ s
           )
   ; OS.Process.exit OS.Process.failure
    )
end
