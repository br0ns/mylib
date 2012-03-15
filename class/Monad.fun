functor Monad (M : Monad) : MonadEX =
struct (Idiom, Func)
open M infix >>= =<< >=> <=< ** >>

(* Idiom interface *)
val pure = return
fun a ** b =
    do f <- a
     ; x <- b
     ; return $ f x
    end

fun a >> b = a >>= (fn _ => b)

fun fail e = return () >>= (fn _ => raise Fail e)

fun join x = x >>= Fn.id

fun seq ms =
    List.foldr
      (fn (m, m') =>
          do x <- m
           ; xs <- m'
           ; return $ x :: xs
          end
      )
      (return nil)
      ms

fun seq' ms = List.foldr op>> (return ()) ms

fun mapM f xs = seq $ List.map f xs

fun mapMPartial f xs =
    List.foldr
      (fn (x, m') =>
          do mx <- f x
           ; case mx of
               NONE   => m'
             | SOME x =>
               do xs <- m'
                ; return $ x :: xs
               end
          end
      )
      (return nil)
      xs

fun mapM' f xs = seq' $ List.map f xs

fun keepM p xs =
    case xs of
      nil     => return nil
    | x :: xs =>
      do px <- p x
       ; ys <- keepM p xs
       ; return (if px then x :: ys else ys)
      end

fun rejectM p xs = keepM (fn x => p x >>= return o not) xs

fun m =<< n = n >>= m

fun (f >=> g) x = f x >>= g

fun (f <=< g) x = g x >>= f

fun forever m = m >>= (fn _ => forever m)

fun foreverWithDelay d m =
    let
      fun sleep () = OS.Process.sleep $
                     Time.fromMilliseconds $
                     LargeInt.fromInt d
      fun loop m = m >>= (fn _ => (sleep () ; loop m))
    in
      loop m
    end

fun ignore m = m >> return ()

fun mapAndUnzipM f xs =
    seq (List.map f xs) >>= (return o ListPair.unzip)

fun zipWithM f ls =
    seq $ List.map f $ ListPair.zip ls

fun zipWithM' f ls =
    seq' $ List.map f $ ListPair.zip ls

fun foldlM _ b nil = return b
  | foldlM f b (x :: xs) = do b' <- f (x, b) ; foldlM f b' xs end

fun foldlM' f b xs = ignore $ foldlM f b xs

fun foldrM f b = foldlM f b o rev

fun foldrM' f b = foldlM' f b o rev

fun tabulateM n m =
    seq $ List.tabulate (n, m)

fun tabulateM' n m =
    seq' $ List.tabulate (n, m)

fun when p m = if p then m else return ()

fun unless p m = if p then return () else m
end
