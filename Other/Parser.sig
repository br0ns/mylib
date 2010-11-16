(* infix 0 |||
 * infix 1 --- |-- --|
 * infix 2 >>> --> ??? produce underlies
 *)

signature Parser =
sig
  include ParserBase
val underlies : ('a, 'b, 'x) parser * ('b, 'c, 'x) parser -> ('a, 'c, 'x) parser
val >>> : ('a, 'b, 'x) parser * ('b -> 'c) -> ('a, 'c, 'x) parser
val --- : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'b * 'c, 'x) parser
val --| : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'b, 'x) parser
val |-- : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'c, 'x) parser
val predicate : ('a -> bool) -> ('a, 'a, 'x) parser
val lookAhead : ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
val produce : ('a, 'b, 'x) parser * 'c -> ('a, 'c, 'x) parser
val token : ''a -> (''a, ''a, 'x) parser
val except : ''a -> (''a, ''a, 'x) parser
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

val chainl1 : ('a, 'b, 'x) parser ->
              ('a, 'b * 'b -> 'b, 'x) parser ->
              ('a, 'b, 'x) parser
val chainl : ('a, 'b, 'x) parser ->
             ('a, 'b * 'b -> 'b, 'x) parser ->
             'b ->
             ('a, 'b, 'x) parser
val chainr1 : ('a, 'b, 'x) parser ->
              ('a, 'b * 'b -> 'b, 'x) parser ->
              ('a, 'b, 'x) parser
val chainr : ('a, 'b, 'x) parser ->
             ('a, 'b * 'b -> 'b, 'x) parser ->
             'b ->
             ('a, 'b, 'x) parser

val eof : ('a, unit, 'x) parser

structure Text : sig
  val char : char -> (char, char, 'x) parser
  val string : string -> (char, string, 'x) parser
  val oneOf : char list -> (char, char, 'x) parser
  val noneOf : char list -> (char, char, 'x) parser
  val spaces : (char, int, 'x) parser
  val space : (char, char, 'x) parser
  val newline : (char, char, 'x) parser
  val tab : (char, char, 'x) parser
  val upper : (char, char, 'x) parser
  val lower : (char, char, 'x) parser
  val alphaNum : (char, char, 'x) parser
  val letter : (char, char, 'x) parser
  val word : (char, string, 'x) parser
  val line : (char, string, 'x) parser
  val digit : (char, char, 'x) parser
  val natural : (char, unit, 'x) parser
  (* val hexDigit : (char, char, 'x) parser *)
  (* val octDigit : (char, char, 'x) parser *)
  val whitespace : (char, unit, 'x) parser
end

structure Lex : sig
  val lexeme : (char, 'a, 'x) parser -> (char, 'a, 'x) parser
  val symbol : string -> (char, string, 'x) parser
  val identifier : {head : (char, char, 'x) parser,
                    tail : (char, char, 'x) parser} ->
                   (char, string, 'x) parser
  val letter : (char, char, 'x) parser
  val word : (char, word, 'x) parser
  val keywords : (string * 'a) list -> (char, 'a, 'x) parser
  val parens : (char, 'a, 'x) parser -> (char, 'a, 'x) parser
  val braces : (char, 'a, 'x) parser -> (char, 'a, 'x) parser
  val angles : (char, 'a, 'x) parser -> (char, 'a, 'x) parser
  val brackets : (char, 'a, 'x) parser -> (char, 'a, 'x) parser
  val semi : (char, string, 'x) parser
  val colon : (char, string, 'x) parser
  val comma : (char, string, 'x) parser
  val dot : (char, string, 'x) parser
  val semiSep : (char, 'a, 'x) parser -> (char, 'a list, 'x) parser
  val semiSep1 : (char, 'a, 'x) parser -> (char, 'a list, 'x) parser
  val commaSep : (char, 'a, 'x) parser -> (char, 'a list, 'x) parser
  val commaSep1 : (char, 'a, 'x) parser -> (char, 'a list, 'x) parser
  val natural : (char, int, 'x) parser
end

structure Parse : sig
  val run : ('a, 'b, 'x) parser ->
            ('a, 'x) reader ->
            'x ->
            ('a, 'b) result

  val vector : ('a, 'b, 'a VectorSlice.slice) parser ->
               'a Vector.vector ->
               ('a, 'b) result

  val string : (char, 'b, substring) parser ->
               string ->
               (char, 'b) result

  val list : ('a, 'b, 'a list) parser ->
             'a list ->
             ('a, 'b) result

  val lazyList : ('a, 'b, 'a LazyList.t) parser ->
                 'a LazyList.t ->
                 ('a, 'b) result

  val file : (char, 'b, char LazyList.t) parser ->
             string ->
             (char, 'b) result


  val testVector : ('a -> string) ->
                   ('a, 'b, 'a VectorSlice.slice) parser ->
                   'a Vector.vector ->
                   'b

  val testString : (char, 'b, substring) parser ->
                   string ->
                   'b

  val testList : ('a -> string) ->
                 ('a, 'b, 'a list) parser ->
                 'a list ->
                 'b

  val testLazyList : ('a -> string) ->
                     ('a, 'b, 'a LazyList.t) parser ->
                     'a LazyList.t ->
                     'b

  val testFile : (char, 'b, char LazyList.t) parser ->
                 string ->
                 'b
end
end
