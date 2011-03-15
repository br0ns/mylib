structure CList :> Seq = Seq (
struct
datatype 'a t =
         L of 'a list
       | C of 'a t * 'a t
datatype 'a viewl =
         nill
       | <:: of 'a * 'a t
datatype 'a viewr =
         nilr
       | ::> of 'a t * 'a

val empty = L nil

fun null (L nil) = true
  | null _ = false

fun singleton x = L [x]

fun xs >< ys =
    case (xs, ys) of
      (L nil, ys) => ys
    | (xs, L nil) => xs
    | (xs, ys)    => C (xs, ys)

fun x <| xs = singleton x >< xs

fun xs |> x = xs >< singleton x

fun viewl xs =
    case xs of
      L nil => nill
    | L (x :: xs) => x <:: L xs
    | C (xs, ys) =>
      case viewl xs of
        x <:: xs => x <:: (xs >< ys)
      | _ => die "viewl"

fun viewr xs =
    case xs of
      L xs =>
      (case rev xs of
         x :: xs => L (rev xs) ::> x
       | nil     => nilr
      )
    | C (xs, ys) =>
      case viewr ys of
        ys ::> y => (xs >< ys) ::> y
      | _ => die "viewr"

fun length xs =
    let
      fun loop (L xs, n) = List.length xs + n
        | loop (C (xs, ys), n) = loop (xs, loop (ys, n))
    in
      loop (xs, 0)
    end

fun xs !! n =
    let
      fun loop (xs, n) =
          case xs of
            L xs =>
            let
              val l = List.length xs
            in
              if l < n then
                Right $ List.nth (xs, n)
              else
                Left $ n - l
            end
          | C (xs, ys) =>
            case loop (xs, n) of
              Left n' => loop (ys, n')
            | x => x
    in
      case loop (xs, n) of
        Right x => x
      | Left _  => raise Subscript
    end

fun modify f n xs =
    let
      fun adjust 0 (x :: xs) = f x :: xs
        | adjust n (x :: xs) = x :: adjust (n - 1) xs
        | adjust _ _ = raise Subscript
      fun loop (xs, n) =
          case xs of
            L xs =>
            let
              val l = List.length xs
            in
              if l < n then
                Right $ L $ adjust n xs
              else
                Left $ n - l
            end
          | C (xs, ys) =>
            case loop (xs, n) of
              Right xs => Right $ C (xs, ys)
            | Left n' =>
              case loop (ys, n') of
                Right ys => Right $ C (xs, ys)
              | x => x
    in
      case loop (xs, n) of
        Right x => x
      | Left _  => raise Subscript
    end

fun fromList xs = L xs

fun map f (L xs) = L $ List.map f xs
  | map f (C (xs, ys)) = C (map f xs, map f ys)

fun foldl f b xs =
    case xs of
      L xs => List.foldl f b xs
    | C (xs, ys) => foldl f (foldl f b xs) ys

fun foldr f b xs =
    case xs of
      L xs => List.foldr f b xs
    | C (xs, ys) => foldr f (foldr f b ys) xs

fun xs >>= f = foldr op>< empty $ map f xs
end)
