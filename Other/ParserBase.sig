signature ParserBase =
sig
  type ('a, 'x) reader = ('a, 'x) StringCvt.reader
  type 'x state
  type ('a, 'x) consumer
  type ('a, 'b, 'x) parser = ('a, 'x) consumer -> ('b, 'x) consumer
  type position
  type 'a result = ({position : position,
                     error    : string} list,
                    'a) Either.t

  val ??? : ('a, 'b, 'x) parser * string -> ('a, 'b, 'x) parser
  val expected : string -> ('a, 'b, 'x) parser
  val unexpected : ('a, 'b, 'x) parser

  val getState : ('a, 'x state, 'x) parser
  val setState : 'x state -> ('a, unit, 'x) parser
  (* val getPosition : ('a, position, 'x) parser *)
  (* val setPosition : position -> ('a, unit, 'x) parser *)
  val any : ('a, 'a, 'x) parser

  (* These look like a generic pattern *)
  val ||| : ('a, 'b, 'x) parser * ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
  val try : ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser

  (* Look ma' - a monad *)
  val --> : ('a, 'b, 'x) parser * ('b -> ('a, 'c, 'x) parser) -> ('a, 'c, 'x) parser
  val return : 'b -> ('a, 'b, 'x) parser

  (* I'm not sure what these are-are *)
  (* val consumer : ('a, 'x) reader -> ('a, 'x) consumer *)
  (* val reader : ('a, 'x) consumer -> ('a, 'x) reader *)

  val parse : ('a, 'b, 'x) parser ->
              ('a -> string) ->
              ('a, 'x) reader ->
              'x -> 'b result * 'x
end
