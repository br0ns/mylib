structure Pretty :> Pretty =
struct
open Lazy General
datatype t' =
         Empty
       | Join    of t * t
       | Line    of bool
       | Nest    of int * t
       | Text    of string
       | Choice  of t * t
       | Nesting of int -> t
       | Column  of int -> t
       | Max     of int option -> t
withtype t = t' Lazy.t
type line = int * string

val empty = eager Empty
val txt = eager o Text

val ln = eager (Line true)
val brk = eager (Line false)
val column = eager o Column
val nesting = eager o Nesting
val max = eager o Max

infix ^^

val op^^ = eager o Join

fun nest n = eager o curry Nest n

fun flatten doc =
    delay
      (fn _ =>
          case force doc of
            Empty         => doc
          | Join (l, r)   => flatten l ^^ flatten r
          | Nest (i, doc) => nest i (flatten doc)
          | Text _        => doc
          | Line b        => if b then txt " " else empty
          | Choice (w, _) => w
          | Column f      => column (flatten o f)
          | Nesting f     => nesting (flatten o f)
          | Max f         => max (flatten o f)
      )

fun choice (w, n) =
    eager (Choice (flatten w, n))
fun group d = choice (d, d)

fun linearize max doc =
    let
      datatype t' =
               Nil
             | Print of string * t
             | Linefeed of int * t
      withtype t = t' Lazy.t

      fun lin doc =
          let
            fun loop (i, acc, doc) =
                case force doc of
                  Nil                => [(i, acc)]
                | Print (str, doc)   => loop (i, acc ^ str, doc)
                | Linefeed (i', doc) => (i, acc) :: loop (i', "", doc)
          in
            loop (0, "", doc)
          end

      fun fits used doc =
          case max of
            NONE   => true
          | SOME c => used <= c andalso
                      case force doc of
                        Print (str, doc) => fits (used + size str) doc
                      | _                => true

      fun best used wl =
          delay
            (fn _ =>
                case wl of
                  nil => eager Nil
                | (nest, doc) :: rest =>
                  case force doc of
                    Empty         =>
                    best used rest
                  | Join (l, r)   =>
                    best used ((nest, l) :: (nest, r) :: rest)
                  | Nest (i, doc) =>
                    best used ((nest + i, doc) :: rest)
                  | Text str      =>
                    eager (Print (str, best (used + size str) rest))
                  | Line _        =>
                    eager (Linefeed (nest, best nest rest))
                  | Choice (w, n) =>
                    let
                      val w = best used ((nest, w) :: rest)
                    in
                      if fits used w then
                        w
                      else
                        best used ((nest, n) :: rest)
                    end
                  | Column f      =>
                    best used ((nest, f used) :: rest)
                  | Nesting f     =>
                    best used ((nest, f nest) :: rest)
                  | Max f         =>
                    best used ((nest, f max) :: rest)
            )
    in
      lin (best 0 [(0, doc)])
    end

fun fold f s max doc = foldl f s (linearize max doc)

local
  fun strs nil = nil
    | strs ((_, "") :: ls) = "\n" :: strs ls
    | strs [(i, s)] = [String.spaces i, s]
    | strs ((i, s) :: ls) = String.spaces i :: s :: "\n" :: strs ls
in
fun pretty n d = String.concat (strs (linearize n d))
end
end
