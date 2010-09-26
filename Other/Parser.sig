(* infix 0 |||
 * infix 1 --- |-- --|
 * infix 2 >>> --> ??? produce
 *)

signature Parser =
sig
  include ParserBase
val >>> : ('a, 'b, 'x) parser * ('b, 'c, 'x) parser -> ('a, 'c, 'x) parser
val --- : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'b * 'c, 'x) parser
val --| : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'b, 'x) parser
val |-- : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'c, 'x) parser
val map : ('b -> 'c) -> ('a, 'b, 'x) parser -> ('a, 'c, 'x) parser
val predicate : ('b -> bool) -> ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
val notFollowedBy : ('a, 'b, 'x) parser -> ('a, unit, 'x) parser
val lookAhead : ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
val produce : ('a, 'b, 'x) parser * 'c -> ('a, 'c, 'x) parser
val token : ''a -> (''a, ''a, 'x) parser
val choice : ('a, 'b, 'x) parser list -> ('a, 'b, 'x) parser
val link : ('a, 'b, 'x) parser list -> ('a, 'b list, 'x) parser
val count : int -> ('a, 'b, 'x) parser -> ('a, 'b list, 'x) parser
val many : ('a, 'b, 'x) parser -> ('a, 'b list, 'x) parser
val many1 : ('a, 'b, 'x) parser -> ('a, 'b list, 'x) parser
val maybe : ('a, 'b, 'x) parser -> ('a, 'b option, 'x) parser
val between : ('a, 'b, 'x) parser ->
              ('a, 'c, 'x) parser ->
              ('a, 'd, 'x) parser -> ('a, 'd, 'x) parser
val followedBy : ('a, 'b, 'x) parser -> ('a, unit, 'x) parser
val manyTill : ('a, 'b, 'x) parser ->
               ('a, 'c, 'x) parser -> ('a, 'b list, 'x) parser
val sepBy : ('a, 'b, 'x) parser ->
            ('a, 'c, 'x) parser ->
            ('a, 'b list, 'x) parser
val sepBy1 : ('a, 'b, 'x) parser ->
             ('a, 'c, 'x) parser ->
             ('a, 'b list, 'x) parser
val endBy : ('a, 'b, 'x) parser ->
            ('a, 'c, 'x) parser ->
            ('a, 'b list, 'x) parser
val endBy1 : ('a, 'b, 'x) parser ->
             ('a, 'c, 'x) parser ->
             ('a, 'b list, 'x) parser
val sepEndBy : ('a, 'b, 'x) parser ->
               ('a, 'c, 'x) parser ->
               ('a, 'b list, 'x) parser
val sepEndBy1 : ('a, 'b, 'x) parser ->
                ('a, 'c, 'x) parser ->
                ('a, 'b list, 'x) parser
val eof : ('a, unit, 'x) parser

structure Text : sig
  val char : char -> (char, char, 'x) parser
  val string : string -> (char, string, 'x) parser
  (* val keywords : string list -> (char, string, 'x) parser *)
(* oneOf char list *)
(* noneOf char list *)
(* spaces *)
(* space *)
(* newline *)
(* tab *)
(* upper *)
(* lower *)
(* alphaNum *)
(* letter *)
(* digit *)
(* hexDigit *)
(* octDigit *)
end

(* structure Lex : sig *)

(* end *)

structure Parse : sig
  val vector : ('a, 'b, 'a VectorSlice.slice) parser ->
               ('a -> string) ->
               'a Vector.vector -> ('a, 'b) result
  val vectorFull : ('a, 'b, 'a VectorSlice.slice) parser ->
                   ('a -> string) ->
                   'a Vector.vector -> ('a, 'b) result

  val run : ('a, 'b, 'x) parser ->
            ('a -> string) ->
            ('a, 'x) reader ->
            'x -> ('a, 'b) result
  val full : ('a, 'b, 'x) parser ->
             ('a -> string) ->
             ('a, 'x) reader ->
             'x -> ('a, 'b) result

  val string : (char, 'b, char VectorSlice.slice) parser ->
               string ->
               (char, 'b) result
  val stringFull : (char, 'b, char VectorSlice.slice) parser ->
                   string ->
                   (char, 'b) result

  val list : ('a, 'b, 'a list) parser ->
             ('a -> string) ->
             'a list ->
             ('a, 'b) result
  val listFull : ('a, 'b, 'a list) parser ->
                 ('a -> string) ->
                 'a list ->
                 ('a, 'b) result

  val file : (char, 'b, char VectorSlice.slice) parser ->
             string ->
             (char, 'b) result
  val fileFull : (char, 'b, char VectorSlice.slice) parser ->
                 string ->
                 (char, 'b) result
end
end
