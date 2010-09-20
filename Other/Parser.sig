(* infix 0 |||
 * infix 1 --- |-- --|
 * infix 2 >>> --> ??? produce
 *)

signature Parser =
sig
  include ParserBase
val depends : ('a -> ('a, 'b, 'x) parser) -> ('a, 'b, 'x) parser
val predicate : ('b -> bool) -> ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
val notFollowedBy : ('a, 'b, 'x) parser -> ('a, unit, 'x) parser
val lookAhead : ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
val >>> : ('a, 'b, 'x) parser * ('b -> 'c) -> ('a, 'c, 'x) parser
val --- : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'b * 'c, 'x) parser
val --| : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'b, 'x) parser
val |-- : ('a, 'b, 'x) parser * ('a, 'c, 'x) parser -> ('a, 'c, 'x) parser
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
val eof : ('a, unit, 'x) parser
val scan : (''a, ''b, 'x) parser -> (''a, 'x) reader -> (''b, 'x) reader

structure Text : sig
  val char : char -> (char, char, 'x) parser
  val string : string -> (char, string, 'x) parser
end
structure Parse : sig
  val vectorPrefix : ('a, 'b, 'a VectorSlice.slice) parser ->
                     ('a -> string) ->
                     'a Vector.vector -> 'b result
  val vectorFull : ('a, 'b, ''a VectorSlice.slice) parser ->
                   ('a -> string) ->
                   'a Vector.vector -> 'b result
  val prefix : ('a, 'b, 'x) parser ->
               ('a -> string) ->
               ('a, 'x) reader ->
               'x -> 'b result
  val full : ('a, 'b, 'x) parser ->
             ('a -> string) ->
             ('a, 'x) reader ->
             'x -> 'b result
  val stringFull : (char, 'b, string) parser ->
                   string ->
                   'b result
  val stringPrefix : (char, 'b, string) parser ->
                     string ->
                     'b result
end
end
