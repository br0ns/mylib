structure List = struct local structure PreML__TMP__XZNLPKQnQp = struct 

open List
type 'a monad = 'a list
fun >>= (xs, k) = List.concat (map k xs)
fun return x = [x]
type 'a alt = 'a list
val || = op@
fun genZero () = nil
type 'a foldable = 'a list
type 'a enumerable = 'a list
type 'a enumerable_elm = 'a
val read = getItem end local structure PreML__TMP__mQzmOpGscU = MonadP ( open PreML__TMP__XZNLPKQnQp ) structure PreML__TMP__siFNBDRSmd = Foldable ( open PreML__TMP__mQzmOpGscU PreML__TMP__XZNLPKQnQp ) structure PreML__TMP__YxjVosnoRW = Enumerable ( open PreML__TMP__mQzmOpGscU PreML__TMP__siFNBDRSmd PreML__TMP__XZNLPKQnQp ) in structure PreML__TMP__XZNLPKQnQp = struct open PreML__TMP__mQzmOpGscU PreML__TMP__siFNBDRSmd PreML__TMP__YxjVosnoRW PreML__TMP__XZNLPKQnQp end end in open PreML__TMP__XZNLPKQnQp end end 


structure Int = struct local structure PreML__TMP__mbTLClFSkH = struct 

open Int
type ordered = int end local structure PreML__TMP__BvbLVvUXOK = WithSet ( open PreML__TMP__mbTLClFSkH ) in structure PreML__TMP__mbTLClFSkH = struct open PreML__TMP__BvbLVvUXOK PreML__TMP__mbTLClFSkH end end in open PreML__TMP__mbTLClFSkH end end 


val xs = let infix 0 >>= val op>>= = Int.Set.>>= val return = Int.Set.return in ( 
                 Int.Set.fromList [1, 2, 4] ) >>= (fn  x => ( 
                 Int.Set.fromList [3, 1, 5, 1] ) >>= (fn  y => 
            return (x + y) ) ) end 

(* = fromList [4, 2, 6, 2, 5, 3, 7, 3, 7, 5, 9, 5]
 * = fromList [2, 3, 4, 5, 6, 7, 9]
 *)

open Int.Set infix ==
val test = xs == Int.Set.fromList [2,3,4,5,6,7,9]