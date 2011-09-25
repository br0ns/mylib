functor Error (X :
               sig
                 type error
                 val noMsg : error
                 val strMsg : string -> error
               end
              ) =
ErrorT (open ID X)
