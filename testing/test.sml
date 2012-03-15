
val _ = List.packWith Int.binPack [42, 7]

(* open Array2 infix >> << *)

(* val is = *)
(*     TextIO.openIn "/home/mortenbp/zomg-pwnies/targets/prosa11/amazing/data" *)

(* fun one _ = ord (valOf (TextIO.input1 is)) *)

(* val arr = tabulate *)
(*             RowMajor *)
(*             (15001, 15001, one) *)

(* datatype dir = N | S | E | W *)

(* fun move (x, y) = *)
(*  fn N => (x, y - 1) *)
(*   | S => (x, y + 1) *)
(*   | E => (x + 1, y) *)
(*   | W => (x - 1, y) *)

(* fun get (x, y) = sub (arr, x, y) *)
(* fun set (x, y) c = update (arr, x, y, c) *)

(* fun || (NONE, x) = x *)
(*   | || (x, _)    = x *)
(* infix || *)

(* val steps = ref 0 *)
(* fun path p = *)
(*     let *)
(*       val c = get p *)
(*     in *)
(*       if c = 3 orelse c = 5 *)
(*       then NONE *)
(*       else if p = (14999, 14999) *)
(*       then SOME [p] *)
(*       else (set p 5 *)
(*           ; steps := !steps + 1 *)
(*           ; (case path $ move p E of *)
(*                SOME ps => SOME (p :: ps) *)
(*              | NONE => *)
(*                case path $ move p W of *)
(*                  SOME ps => SOME (p :: ps) *)
(*                | NONE => *)
(*                  case path $ move p N of *)
(*                    SOME ps => SOME (p :: ps) *)
(*                  | NONE => *)
(*                    case path $ move p S of *)
(*                      SOME ps => SOME (p :: ps) *)
(*                    | NONE => NONE *)
(*             ) *)
(*            ) *)
(*     end *)

(* val _ = print "begin\n" *)
(* val p = valOf $ path (1, 1) *)
(* val _ = print $ Int.toString $ length p *)
(* val _ = print "\n" *)
(* val _ = print $ Int.toString $ !steps *)
(* val _ = print "\n" *)

(* val _ = List.app (fn p => set p 4) p *)

(* (\* val arr = tabulate (Int.* (15001, 15001), one) *\) *)

(* (\* val dat = TextIO.inputAll is *\) *)

(* (\* val _ = print (TextIO.inputAll is) *\) *)

(* val _ = TextIO.closeIn is *)

(* val _ = print "done\n" *)

(* val os = *)
(*     TextIO.openOut "/home/mortenbp/zomg-pwnies/targets/prosa11/amazing/data" *)

(* val _ = app RowMajor (fn c => TextIO.output1 (os, chr c)) arr *)

(* val _ = TextIO.closeOut os *)

(* (\* val _ = List.app (print o Int.toString) p *\) *)

(* (\* val _ = app RowMajor *\) *)
(* (\*             (fn (a, b, c, d) => *\) *)
(* (\*                 (print (toString a) *\) *)
(* (\*                ; print (toString b) *\) *)
(* (\*                ; print (toString c) *\) *)
(* (\*                ; print (toString d))) arr *\) *)


