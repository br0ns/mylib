structure Scanner :> Scanner =
struct (MonadP)
type ('a, 'b, 'x) t = ('a, 'b, 'x) scanner

fun (m >>= k) r =
    do with Reader
     ; a <- m r
     ; k a r
    end

fun return x _ =
    Reader.return x

fun genZero () _ = Reader.genZero ()

fun (m || n) r = Reader.|| (m r, n r)

end
