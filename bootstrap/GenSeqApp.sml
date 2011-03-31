

fun var n = "v" ^ Int.toString n
fun vars n m =
    String.concat
      (List.tabulate
         (n, fn n => ", " ^ var (m + n))
      )
fun genApp n =
    let
      val app = "app" ^ Int.toString n

      val ts = vars n 0

      val cons =
          List.foldr
            (fn (v, s) => "consTree (" ^ v ^ ", " ^ s ^ ")")
            "ys"
            (List.tabulate (n, var))

      val snoc =
          List.foldl
            (fn (v, s) => "snocTree (" ^ s ^ ", " ^ v ^ ")")
            "xs"
            (List.tabulate (n, var))

      fun build _ 0 = nil
        | build n 2 = ["B2 (" ^ var (n - 2) ^ ", " ^ var (n - 1) ^ ")"]
        | build n 4 = ["B2 (" ^ var (n - 4) ^ ", " ^ var (n - 3) ^ ")",
                       "B2 (" ^ var (n - 2) ^ ", " ^ var (n - 1) ^ ")"]
        | build n m = ("B3 (" ^ var (n - m) ^ ", " ^ var (n - m + 1) ^
                       ", " ^ var (n - m + 2) ^ ")") :: build n (m - 3)
      fun digit n m =
          case n of
            1 => "One " ^ var m
          | 2 => "Two (" ^ var m ^ ", " ^ var (m + 1) ^ ")"
          | 3 => "Three (" ^ var m ^ ", " ^ var (m + 1) ^
                 ", " ^ var (m + 2) ^ ")"
          | 4 => "Four (" ^ var m ^ ", " ^ var (m + 1) ^
                 ", " ^ var (m + 2) ^ ", " ^ var (m + 3) ^ ")"
          | _ => ""

      fun appDigit l r =
          "| " ^ app ^ " (D (prl, ml, " ^
          digit l 0 ^
          "), D (" ^
          digit r (n + l) ^
          ", mr, sfr)" ^ vars n l ^ ") =\n" ^
          let
            val n' = l + n + r
            val ts = build n' n'
          in
            "D (prl, app" ^ Int.toString (length ts) ^ " (ml, mr" ^
            foldr (fn (t, s) => ", " ^ t ^ s) "" ts ^ "), sfr)"
          end

      fun loop 0 _ = ""
        | loop n 0 = loop (n - 1) 4
        | loop n m = loop n (m - 1) ^ "\n" ^ appDigit n m
    in
      app ^ " (E, ys" ^ ts ^ ") = " ^ cons ^ "\n| " ^
      app ^ " (xs, E" ^ ts ^ ") = " ^ snoc ^ "\n| " ^
      app ^ " (S t, ys" ^ ts ^ ") = consTree (t, " ^ cons ^ ")\n| " ^
      app ^ " (xs, S t" ^ ts ^ ") = snocTree (" ^ snoc ^ ", t)" ^
      loop 4 4
    end

fun gen () =
    "fun " ^ genApp 0 ^ "\n" ^
    "and " ^ genApp 1 ^ "\n" ^
    "and " ^ genApp 2 ^ "\n" ^
    "and " ^ genApp 3 ^ "\n" ^
    "and " ^ genApp 4
