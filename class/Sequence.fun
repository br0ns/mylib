functor Sequence (S : Sequence) : SequenceEX =
struct (MonadP, Foldable, Enumerable, Unfoldable)
type 'a elm = 'a
type 'a t = 'a S.t

val op <\ = Fn.<\
open ViewL ViewR
open Foldable(S)
open S
infix ::> |> >< !!
infixr <| <::

fun singleton x = x <| genEmpty ()

fun op !! (s, i) = index i s

fun delete s 0 = s
  | delete s i =
    case getl s of
      SOME (x, s) => x <| delete s (i - 1)
    | NONE        => raise Subscript

fun append s t = s >< t

fun viewl s =
    case getl s of
      SOME (x, s) => x <:: s
    | NONE        => nill

fun viewr s =
    case getr s of
      SOME (x, s) => s ::> x
    | NONE        => nilr

local
  fun mk pick get = pick o Option.reflect Empty o get
in
fun head s = mk Pair.fst getl s
fun tail s = mk Pair.snd getl s
fun split s = mk Fn.id getl s
fun last s = mk Pair.fst getr s
fun init s = mk Pair.snd getr s
fun splitLast s = mk Fn.id getr s
end

fun cons x s = x <| s
fun snoc x s = s |> x

fun lookup s i = SOME (s !! i) handle Subscript => NONE

fun update s i x = adjust (Fn.const x) i s

fun drop (s, 0) = s
  | drop (s, n) = drop (tail s, n - 1)
    handle Empty => raise Subscript

fun take (s, 0) = genEmpty ()
  | take (s, n) =
    let
      val (x, s) = Option.reflect Subscript $ getl s
    in
      x <| take (s, n - 1)
    end

fun takeDrop (s, n) =
    let
      fun loop (0, s) = (genEmpty (), s)
        | loop (n, s) =
          let
            val (x, s') = Option.reflect Subscript $ getl s
            val (t, d) = loop (n - 1, s')
          in
            (x <| t, d)
          end
    in
      loop (n, s)
    end

fun splitAt n s =
    if n < 0 then raise Subscript
    else
      let
        fun loop (n, s) =
            let
              val (x, s') = Option.reflect Subscript $ getl s
            in
              if n = 0 then
                (genEmpty (), x, s')
              else
                let
                  val (l, y, r) = loop (n - 1, s')
                in
                  (x <| l, y, r)
                end
            end
      in
        loop (n, s)
      end

fun concat ss = foldr op>< (genEmpty ()) ss
fun concatMap f = concat o map f

fun revAppend (s, t) = foldl op<| t s

fun rev s = revAppend (s, genEmpty ())

fun tabulate (n, f) =
    Fn.fix
    (fn loop =>
     fn i =>
        if i >= n
        then genEmpty ()
        else f n <| loop (i + 1)
    ) 0

fun collate cmp (ss, ts) =
    case (viewl ss, viewl ts) of
      (nill, nill) => EQUAL
    | (nill, _)    => LESS
    | (_, nill)    => GREATER
    | (s <:: ss', t <:: ts') =>
      case cmp (s, t) of
        EQUAL   => collate cmp (ss', ts')
      | LESS    => LESS
      | GREATER => GREATER

fun partition p =
    foldr (fn (x, (t, f)) => if p x then (x <| t, f) else (t, x <| f))
          (genEmpty (), genEmpty ())

fun sort cmp s =
    case viewl s of
      nill => genEmpty ()
    | p <:: s =>
      let
        fun part (x, (l, e, g)) =
            case cmp (x, p) of
              LESS    => (x <| l, e, g)
            | EQUAL   => (l, x <| e, g)
            | GREATER => (l, e, x <| g)
        val (l, e, g) = foldl part (genEmpty (), singleton p, genEmpty ()) s
      in
        sort cmp l >< e >< sort cmp g
      end

(* sort = sortBy compare *)
(* sortBy cmp = mergeAll . sequences *)
(*   where *)
(*     sequences (a:b:xs) *)
(*       | a `cmp` b == GT = descending b [a]  xs *)
(*       | otherwise       = ascending  b (a:) xs *)
(*     sequences xs = [xs] *)
(*     descending a as (b:bs) *)
(*       | a `cmp` b == GT = descending b (a:as) bs *)
(*     descending a as bs  = (a:as): sequences bs *)
(*     ascending a as (b:bs) *)
(*       | a `cmp` b /= GT = ascending b (\ys -> as (a:ys)) bs *)
(*     ascending a as bs   = as [a]: sequences bs *)
(*     mergeAll [x] = x *)
(*     mergeAll xs  = mergeAll (mergePairs xs) *)
(*     mergePairs (a:b:xs) = merge a b: mergePairs xs *)
(*     mergePairs xs       = xs *)
(*     merge as@(a:as') bs@(b:bs') *)
(*       | a `cmp` b == GT = b:merge as  bs' *)
(*       | otherwise       = a:merge as' bs *)
(*     merge [] bs         = bs *)
(*     merge as []         = as *)

fun shuffle s =
    let
      val seed = (Int.fromLarge o Time.toSeconds o Time.now) ()
      val gen  = Random.rand (seed, 101010)
      fun rndBool _ = Random.randRange (0,2) gen = 0
      fun loop s =
          if null s
          then s
          else
            let
              val (l, r) = partition rndBool s
            in
              loop l >< loop r
            end
    in
      loop s
    end

fun allPairs s = concatMap (fn x => map (x,) s) s

fun allSplits s = tabulate (length s, s <\ takeDrop)

fun consAll x = map (x <\ op<|)

fun slice (s, l, r) =
    let
      val len = length s
      fun index n = if n >= 0
                    then n
                    else len - n
      val l = index $ Option.getOpt (l, 0)
      val r = index $ Option.getOpt (r, ~1)
    in
      if l > r orelse l < 0 orelse l >= len orelse r < 0 orelse r >= len
      then raise Subscript
      else drop (take (s, r - l + 1), l)
    end

fun groupBy eq s =
    case viewl s of
      nill    => genEmpty ()
    | x <:: s =>
      let
        val (s, t) = partition (x <\ eq) s
      in
        (x <| s) <| groupBy eq t
      end

fun group s = groupBy op= s

local
  fun mk cons p =
      cons o foldr (fn (x, (s, ss)) =>
                       if p x
                       then (genEmpty (), cons (s, ss))
                       else (x <| s, ss)
                   ) (genEmpty (), genEmpty ())
in
fun fields p = mk op <| p
fun tokens p = mk (fn (s, ss) => if null s then ss else s <| ss) p
end

fun power s =
    let
      fun loop s =
          case viewl s of
            nill => genEmpty ()
          | x <:: s =>
            singleton x <| foldl (fn (s, ss) => s <| (x <| s) <| ss)
                      (genEmpty ()) (loop s)
    in
      genEmpty () <| loop s
    end

fun permutations s =
    let
      fun weave x s =
          case viewl s of
            nill => singleton $ singleton x
          | y <:: s' => (x <| s) <| consAll y (weave x s')
      fun loop s =
          case viewl s of
            nill    => singleton s
          | x <:: s => concatMap (weave x) (loop s)
    in
      loop s
    end

fun tails s = s <| tails (tail s) handle Empty => genEmpty ()
fun inits s =
    let
      fun loop (s, t) =
          loop (init s, s <| t)
          handle Empty => s <| t
    in
      loop (s, genEmpty ())
    end

fun subsequences s =
    let
      fun loop s =
          case viewl s of
            nill => genEmpty ()
          | x <:: s =>
            let
              val ss = loop s
            in
              singleton x <| (consAll x ss >< ss)
            end
    in
      loop s
    end

fun intersperse x s =
    case viewl s of
      nill => s
    | y <:: s' =>
      if null s'
      then s
      else y <| foldr (fn (y, s) => x <| y <| s) (genEmpty ()) s'

fun unzip s =
    case viewl s of
      nill => (genEmpty (), genEmpty ())
    | (x, y) <:: s =>
      let
        val (xs, ys) = unzip s
      in
        (x <| xs, y <| ys)
      end

fun transpose ss =
    if any null ss
    then genEmpty ()
    else
      let
        val (fst, rest) = unzip $ map split ss
      in
        fst <| transpose rest
      end

local
  fun mk fold f b =
      op<| o fold (fn (x, (b, bs)) => (f (x, b), b <| bs)) (b, genEmpty ())
  fun mkw foldw f b =
      op<| o foldw (fn (x, (b, bs)) => Pair.mapFst (,b <| bs) $ f (x, b))
                   (b, genEmpty ())
in
fun scanl ? = mk foldl ?
fun scanr ? = mk foldr ?
fun scanlWhile ? = mkw foldlWhile ?
fun scanrWhile ? = mkw foldrWhile ?
end

local
  fun maybe f (x, bop) =
      SOME
        (case bop of
           SOME (b, bs) => (f (x, b), b <| bs)
         | NONE         => (x, singleton x)
        )
in
fun scanl1 f s =
    Option.map op<| $ foldl (maybe f) NONE s
fun scanr1 f s =
    Option.map op<| $ foldr (maybe f) NONE s
end


fun mapAccumL f b s =
    let
      fun loop (s, b) =
          case viewl s of
            nill => (genEmpty (), b)
          | x <:: s =>
            let
              val (x, b) = f (x, b)
              val (s, b) = loop (s, b)
            in
              (x <| s, b)
            end
    in
      loop (s, b)
    end

fun mapAccumR f b =
    foldr (fn (x, (t, b)) =>
              let
                val (x, b) = f (x, b)
              in
                (x <| t, b)
              end) (genEmpty (), b)

fun replicate n x =
    let
      fun loop (0, s) = s
        | loop (n, s) = loop (n - 1, x <| s)
    in
      if n < 0
      then raise Domain
      else loop (n, genEmpty ())
    end

fun break p s =
    case viewl s of
      nill => (genEmpty (), s)
    | x <:: s' =>
      if p x
      then (genEmpty (), s)
      else
        let
          val (s, t) = break p s'
        in
          (x <| s, t)
        end

fun span p = break (not o p)

fun takeWhile p = Pair.fst o span p
fun dropWhile p = Pair.snd o span p

fun stripPrefix s t =
    case (viewl s, viewl t) of
      (nill, _) => SOME t
    | (x <:: s, y <:: t) =>
      if x = y
      then stripPrefix s t
      else NONE
    | _ => NONE

fun isPrefixOf s t =
    case (viewl s, viewl t) of
      (nill, _) => true
    | (x <:: s, y <:: t) =>
      x = y andalso isPrefixOf s t
    | _ => false

fun isInfixOf s t = any (isPrefixOf s) $ tails t

fun isSuffixOf s t = isPrefixOf (rev s) $ rev t

fun findIndex p s =
    let
      exception Found of int
    in
      (foldl (fn (x, n) => if p x then raise Found n else n + 1) 0 s
     ; NONE
      ) handle Found n => SOME n
    end

fun findIndices p =
    Pair.snd o foldl (fn (x, (n, ns)) => (n + 1, if p x then n <| ns else ns))
                     (0, genEmpty())

fun memberIndex x = findIndex (x <\ op=)
fun memberIndices x = findIndices (x <\ op=)

fun toList s = foldr op:: nil s
fun fromList xs = List.foldr op<| (genEmpty ()) xs

val lines = fromList o String.fields (#"\n" <\ op=)

val unlines = String.concat o toList o intersperse "\n"

val words = fromList o String.tokens Char.isSpace

val unwords = String.concat o toList o intersperse " "

fun nub s =
    case viewl s of
      nill => s
    | x <:: s =>
      let
        val s = nub s
      in
        if member x s
        then s
        else x <| s
      end

fun somes s =
    case viewl s of
      nill => genEmpty ()
    | SOME x <:: s => x <| somes s
    | NONE   <:: s => somes s

fun zipWith f (s, t) =
    case (viewl s, viewl t) of
      (a <:: s, b <:: t) => f (a, b) <| zipWith f (s, t)
    | _ => genEmpty ()

fun zip ? = zipWith Fn.id ?

fun zipWith3 f (s, t, u) =
    case (viewl s, viewl t, viewl u) of
      (a <:: s, b <:: t, c <:: u) => f (a, b, c) <| zipWith3 f (s, t, u)
    | _ => genEmpty ()

fun zip3 ? = zipWith3 Fn.id ?

fun unzip3 s =
    case viewl s of
      nill => (genEmpty (), genEmpty (), genEmpty ())
    | (a, b, c) <:: s =>
      let
        val (s, t, u) = unzip3 s
      in
        (a <| s, b <| t, c <| u)
      end

fun zipWith4 f (s, t, u, v) =
    case (viewl s, viewl t, viewl u, viewl v) of
      (a <:: s, b <:: t, c <:: u, d <:: v) =>
      f (a, b, c, d) <| zipWith4 f (s, t, u, v)
    | _ => genEmpty ()

fun zip4 ? = zipWith4 Fn.id ?

fun unzip4 s =
    case viewl s of
      nill => (genEmpty (), genEmpty (), genEmpty (), genEmpty ())
    | (a, b, c, d) <:: s =>
      let
        val (s, t, u, v) = unzip4 s
      in
        (a <| s, b <| t, c <| u, d <| v)
      end

fun zipWith5 f (s, t, u, v, w) =
    case (viewl s, viewl t, viewl u, viewl v, viewl w) of
      (a <:: s, b <:: t, c <:: u, d <:: v, e <:: w) =>
      f (a, b, c, d, e) <| zipWith5 f (s, t, u, v, w)
    | _ => genEmpty ()

fun zip5 ? = zipWith5 Fn.id ?

fun unzip5 s =
    case viewl s of
      nill => (genEmpty (), genEmpty (), genEmpty (), genEmpty (), genEmpty ())
    | (a, b, c, d, e) <:: s =>
      let
        val (s, t, u, v, w) = unzip5 s
      in
        (a <| s, b <| t, c <| u, d <| v, e <| w)
      end

(* MonadP *)
fun >>= (m, k) = concatMap (fn x => k x handle Match => genEmpty ()) m
val return = singleton
val op|| = op><
val genZero = genEmpty
(* Enumerable *)
val read = getl
(* Unfoldable *)
fun write x s = x <| s
end
