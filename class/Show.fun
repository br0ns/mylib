functor Show (S : Show) : ShowEX =
struct
open S

(* type s0 = string list *)
(* fun show x = concat $ rev $ showPack (Fn.curry op::) x nil *)
fun show x = concat $ showPack x (fn x => fn k => fn b => k (x :: b)) Fn.id nil

(* type s3 = unit *)
fun toOutstream os x = showPack x (fn s => fn _ => TextIO.output (os, s)) ()

(* type s1 = unit *)
fun showToFile f x =
    let
      val os = TextIO.openOut f
    in
      toOutstream os x
    ; TextIO.closeOut os
    end

(* type s2 = unit *)
fun print x = toOutstream TextIO.stdOut x
val prints = List.app print

fun println x = (print x ; TextIO.print "\n")
val printsln = List.app println
end
