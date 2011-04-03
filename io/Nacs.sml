structure Nacs :> Nacs =
struct
fun create toString write (x, s) = write (toString x, s)

type s0 = string list
fun string nacs x = concat $ rev $ nacs op:: (x, nil)

type s3 = unit
fun outstream nacs os x = nacs (fn (s, _) => TextIO.output (os, s)) (x, ())

type s1 = unit
fun file nacs f x =
    let
      val os = TextIO.openOut f
    in
      outstream nacs os x
    ; TextIO.closeOut os
    end

type s2 = unit
fun stdOut nacs = outstream nacs TextIO.stdOut

type s4 = string list
fun charList nacs = explode o string nacs

type s5 = char seq
fun charSeq nacs x =
    let
      fun write (s, cs) =
          Seq.>< (cs, Vector.foldr Seq.<| Seq.empty s)
    in
      nacs write (x, Seq.empty)
    end

type s6 = string list
fun charStream nacs = Vector.foldr Stream.<| Stream.empty o string nacs
end
