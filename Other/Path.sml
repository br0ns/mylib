(* TODO: Review with regard to symbolic links. As it is now, it almost certainly
   doesn't work.
   Read path variables from a file
*)

structure Path :> Path =
struct
structure P = OS.Path

(* Invariant: Values of type t represent absolute canonical paths *)
type t = string

structure Map = Dictionary
structure Set = StringSet

exception Path of string

(* TODO: This is a ugly hack. It should be determined by some build files
   instead, but hey it works. *)
val mlb_path_map =
    let
      val common = [("SML_LIB", "/usr/lib/mlton/sml"),
                    ("LIB_MLTON_DIR", "/usr/lib/mlton"),
                    ("TARGET", "self"),
                    ("TARGET_ARCH", "x86"),
                    ("TARGET_OS", "linux")]
      val bit32 = [("OBJPTR_REP", "rep32"),
                   ("HEADER_WORD", "word32"),
                   ("SEQINDEX_INT", "int32"),
                   ("DEFAULT_CHAR", "char8"),
                   ("DEFAULT_WIDECHAR", "widechar32"),
                   ("DEFAULT_INT", "int32"),
                   ("DEFAULT_REAL", "real64"),
                   ("DEFAULT_WORD", "word32")]

      val bit64 = [("OBJPTR_REP", "objptr-rep32.sml"),
                   ("HEADER_WORD", "header-word32.sml"),
                   ("SEQINDEX_INT", "seqindex-int32.sml"),
                   ("DEFAULT_CHAR", "default-char8.sml"),
                   ("DEFAULT_WIDECHAR", "default-widechar32.sml"),
                   ("DEFAULT_INT", "default-int32.sml"),
                   ("DEFAULT_REAL", "default-real64.sml"),
                   ("DEFAULT_WORD", "default-word32.sml")]

      (* Type needed by the abstract proc type to make it TextIO streams. *)
      type uproc = (TextIO.instream, TextIO.outstream) Unix.proc

      val pr : uproc = Unix.execute ("/bin/uname", ["-m"])
      val is = Unix.textInstreamOf pr
      val machine =  TextIO.inputLine is before TextIO.closeIn is
      val _ = Unix.reap pr (* Let the process stop naturally *)
    in
      case machine of
        SOME "i686\n" => common @ bit32
      | SOME "x86_64\n" => common @ bit64
      | SOME m =>
        raise Fail ("Path: machine/architecture not implemented: " ^ m)
      | NONE => raise Fail "Path: \"uname -m\" didn't return anything."
    end

val vars = Dictionary.fromList mlb_path_map

fun expandVars f =
    let
      fun read (#"$" :: #"(" :: cs, seen) =
          let
            val (var, cs) = readVar cs
            val var = implode var
          in
            if StringSet.member seen var then
              raise Path ("Recursive path variable: " ^ var)
            else
              case Dictionary.lookup vars var of
                SOME path => read (explode path, StringSet.insert seen var) @
                             read (cs, seen)
              | NONE => raise Path ("Unknown path variable: " ^ var)
          end
        | read (c :: cs, seen) = c :: read (cs, seen)
        | read _ = nil
      and readVar (#")" :: cs) = (nil, cs)
        | readVar (c :: cs) =
          let
            val (cs, cs') = readVar cs
          in
            (c :: cs, cs')
          end
        | readVar _ = (nil, nil)
    in
      implode (read (explode f, StringSet.empty))
    end

fun path f = f
val toString = path

fun new f =
    let
      val f = expandVars f
    in
      if P.isAbsolute f then
        P.mkCanonical f
      else
        raise Path "Cannot create a relative path"
    end

fun new' f f' =
    let
      val f' = expandVars f'
    in
      if P.isAbsolute f' then
        new f'
      else
        new (P.concat (f, f'))
    end

fun append f f' = new $ toString f ^ f'

fun path' f f' = P.mkCanonical (P.mkRelative {path = f', relativeTo = f})

val file = P.file
val dir = P.dir
val base = P.base
val extension = P.ext

val sub = String.isPrefix

val show = Layout.txt
fun relative s = new' (OS.FileSys.getDir ()) s
end
