functor RedBlackSet (E : Ordered) :> Set = Set (
struct
open E
type element = ordered

datatype color = R | B
datatype t = E
           | T of color * t * element * t

val empty = E
fun null E = true
  | null _ = false

fun singleton x = T (B, E, x, E)

fun sub1 (T (B, l, y, r)) = T (R, l, y, r)
  | sub1 _ = die "Invariance violation"

fun balance (T (R,  ll,                   ly,  lr))                    y (T (R, rl, ry,  rr))                                        = T (R, (T (B, ll,  ly,  lr)),   y, (T (B, rl,   ry,  rr)))
  | balance (T (R, (T (R, ll, lly, llr)), ly,  lr))                    y  r                                                          = T (R, (T (B, ll, lly, llr)),  ly, (T (B, lr,    y,   r)))
  | balance (T (R,  ll,                   ly, (T (R, lrl, lry, lrr)))) y  r                                                          = T (R, (T (B, ll,  ly, lrl)), lry, (T (B, lrr,   y,   r)))
  | balance  l                                                         y (T (R,  rl,                    ry, (T (R, rrl, rry, rrr)))) = T (R, (T (B,  l,   y,  rl)),  ry, (T (B, rrl, rry, rrr)))
  | balance  l                                                         y (T (R, (T (R, rll, rly, rlr)), ry,  rr))                    = T (R, (T (B,  l,   y, rll)), rly, (T (B, rlr,  ry,  rr)))
  | balance  l                                                         y  r = T (B, l, y, r)

fun balanceLeft (T (R, ll, ly, lr)) y  r                                      = T (R, T (B, ll, ly, lr), y, r)
  | balanceLeft  l                  y (T (B, rl, ry, rr))                     = balance l y (T (R, rl, ry, rr))
  | balanceLeft  l                  y (T (R, (T (B, rll, rly, rlr)), ry, rr)) = T (R, (T (B, l, y, rll)), rly, (balance rlr ry (sub1 rr)))
  | balanceLeft _ _ _ = die "Invariance violation"

fun app E r = r
  | app l E = l
  | app (T (R, ll, ly, lr)) (T (R, rl, ry, rr)) =
    (case app lr rl of
       T (R, l, y, r) => T (R, (T (R, ll, ly, l)), y, (T (R, r, ry, rr)))
     | x => T (R, ll, ly, (T (R, x, ry, rr)))
    )
  | app (T (B, ll, ly, lr)) (T (B, rl, ry, rr))  =
    (case app lr rl of
       T (R, l, y, r) => T (R, (T (B, ll, ly, l)), y, (T (B, r, ry, rr)))
     | x => balanceLeft ll ly (T (B, x, ry, rr))
    )
  | app l (T (R, rl, ry, rr))  = T (R, (app l rl), ry, rr)
  | app (T (R, ll, ly, lr)) r  = T (R, ll, ly, (app lr r))

fun balanceRight  l                                      y (T (R, rl, ry, rr)) = T (R, l, y, (T (B, rl, ry, rr)))
  | balanceRight (T (B, ll, ly, lr))                     y  r                  = balance (T (R, ll, ly, lr)) y r
  | balanceRight (T (R, ll, ly, (T (B, lrl, lry, lrr)))) y  r                  = T (R, balance (sub1 ll) ly lrl, lry, T (B, lrr, y, r))
  | balanceRight _ _ _ = die "Invariance violation"

fun insert s x =
    let
      fun insert' E = T (R, E, x, E)
        | insert' (s as T (B, l, y, r)) =
          (case Element.compare x y of
             LESS    => balance (insert' l) y  r
           | GREATER => balance l           y (insert' r)
           | EQUAL   => s)
        | insert' (s as T (R, l, y, r)) =
          (case Element.compare x y of
             LESS     => T (R, insert' l, y, r)
           | GREATER  => T (R, l,         y, insert' r)
           | EQUAL    => s)
    in
      case insert' s of
        T (_, l, x, r) => T (B, l, x, r)
      | _              => die "Impossible"
    end

fun delete s x =
    let
      fun delete' E = E
        | delete' (T (_, l, y, r)) =
          case Element.compare x y of
            LESS => delFromLeft l y r
          | GREATER => delFromRight l y r
          | EQUAL => app l r

      and delFromLeft (l as T (B, _, _, _)) y r = balanceLeft (delete' l) y r
        | delFromLeft l y r = T (R, (delete' l), y, r)

      and delFromRight l y (r as T (B, _, _, _)) = balanceRight l y (delete' r)
        | delFromRight l y r = T (R, l, y, (delete' r))
    in
      case delete' s of
        T (_, l, y, r) => T (B, l, y, r)
      | _             =>  E
    end

datatype viewl =
         nill
       | <:: of element * t
datatype viewr =
         nilr
       | ::> of t * element

fun viewl s =
    let
      fun delete' E = nill
        | delete' (T (_, E, x, r)) = x <:: r
        | delete' (T (_, l, y, r)) =
          delFromLeft l y r
      and delFromLeft (l as T (B, _, _, _)) y r = balanceLeft (delete' l) y r
        | delFromLeft l y r = T (R, (delete' l), y, r)
    in
      case delete' s of
        x <:: T (_, l, y, r) => x <:: T (B, l, y, r)
      | res => res
    end

fun viewr s =
    let
      fun delete' E = nilr
        | delete' (T (_, l, x, E)) = l ::> x
        | delete' (T (_, l, y, r)) =
          delFromRight l y r
      and delFromRight l y (r as T (B, _, _, _)) = balanceRight l y (delete' r)
        | delFromRight l y r = T (R, l, y, (delete' r))
    in
      case delete' s of
        T (_, l, y, r) ::> x => T (B, l, y, r) ::> x
      | res => res
    end

fun foldl _ b E = b
  | foldl f b (T (_, l, x, r)) = foldl f (f (x, foldl f b l)) r

fun foldr _ b E = b
  | foldr f b (T (_, l, x, r)) = foldr f (f (x, foldr f b r)) l

fun member E _ = false
  | member (T (_, l, y, r)) x =
    case Element.compare x y of
      LESS    => member l x
    | GREATER => member r x
    | EQUAL   => true

fun size s =
    let
      fun loop s n =
          case s of
            E => n + 1
          | T (_, l, _, r) = loop l (loop r n)
    in
      loop s 0
    end
end)
