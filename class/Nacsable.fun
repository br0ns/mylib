functor Nacsable (S : NacsableBase) : Nacsable =
struct
open S

fun create toString write (x, s) = write (toString x, s)

(* type s0 = string list *)
fun toString x = concat $ rev $ nacs op:: (x, nil)

(* type s3 = unit *)
fun toOutstream os x = nacs (fn (s, _) => TextIO.output (os, s)) (x, ())

(* type s1 = unit *)
fun toFile f x =
    let
      val os = TextIO.openOut f
    in
      toOutstream os x
    ; TextIO.closeOut os
    end

(* type s2 = unit *)
fun toStdOut x = toOutstream TextIO.stdOut x

(* type s4 = string list *)
fun toCharList x =
    List.concat $ rev $ nacs (fn (x, xs) => explode x :: xs) (x, nil)

(* type s5 = char seq *)
fun toCharSeq x =
    nacs (fn (s, cs) => Vector.foldr Seq.<| cs s) (x, Seq.empty)

fun toCharVector x = toString x

(* type s6 = string list *)
fun toCharStream x =
    nacs (fn (s, cs) => Vector.foldr Stream.<| cs s) (x, Stream.empty)
end
