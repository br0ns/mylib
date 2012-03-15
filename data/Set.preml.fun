functor Set (S : Set) :
        sig
          include MonoMonad MonoMonad_EX
                  Enumerable Enumerable_EX
                  Unfoldable Unfoldable_EX
                  MonoFoldable_EX
                  Ordered Ordered_EX
                  Set Set_EX
        end = struct local structure PreML__TMP__Othhqobiut = struct 

open S

val singleton = insert empty
fun union s = foldl (fn (e, s) => insert s e) s

type monad = set
type monad_elm = elm
fun >>= (s, k) = foldl (fn (e, s') => union (k e) s') empty s
val return = singleton
fun genZero ? = empty
val || = Util.uncurry union structure PreML__TMP__cyVTMElUBb = 

     MonoFoldable(
type foldable = set
type foldable_elm = elm
val foldl = foldl
) open PreML__TMP__cyVTMElUBb 

fun delete s e =
    case remove s e of
      SOME s' => s'
    | NONE    => s

fun split s = let val e = first s in (e, delete s e) end

type 'a enumerable = set
type 'a enumerable_elm = elm
fun read s = SOME (split s) handle Empty => NONE

fun insert s e = union (singleton e) s

type 'a unfoldable = set
type 'a unfoldable_elm = elm
fun write (e, s) = insert s e
val genEmpty = genZero

type ordered = set
fun compare (s, t) =
    case (read s, read t) of
      (NONE, NONE)   => EQUAL
    | (SOME _, NONE) => GREATER
    | (NONE, SOME _) => LESS
    | (SOME (se, s'), SOME (te, t')) =>
      case compareElm (se, te) of
        EQUAL => compare (s', t')
      | order => order end local structure PreML__TMP__ywkzrgKbHp = MonoMonadP ( open PreML__TMP__Othhqobiut ) structure PreML__TMP__diJckpfnMJ = MonoFoldable ( open PreML__TMP__ywkzrgKbHp PreML__TMP__Othhqobiut ) structure PreML__TMP__DpFqcFJaOD = Enumerable ( open PreML__TMP__ywkzrgKbHp PreML__TMP__diJckpfnMJ PreML__TMP__Othhqobiut ) structure PreML__TMP__yDMjRIakaw = Unfoldable ( open PreML__TMP__ywkzrgKbHp PreML__TMP__diJckpfnMJ PreML__TMP__DpFqcFJaOD PreML__TMP__Othhqobiut ) structure PreML__TMP__wVQApAHHkL = Ordered ( open PreML__TMP__ywkzrgKbHp PreML__TMP__diJckpfnMJ PreML__TMP__DpFqcFJaOD PreML__TMP__yDMjRIakaw PreML__TMP__Othhqobiut ) in structure PreML__TMP__Othhqobiut = struct open PreML__TMP__ywkzrgKbHp PreML__TMP__diJckpfnMJ PreML__TMP__DpFqcFJaOD PreML__TMP__yDMjRIakaw PreML__TMP__wVQApAHHkL PreML__TMP__Othhqobiut end end in open PreML__TMP__Othhqobiut end end