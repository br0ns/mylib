signature Nacser = sig
  type ('a, 'b, 'x) t =
       ('a * 'x -> 'x) -> 'b * 'x -> 'x

  val combine : ('a, 'b, 'x) nacser ->
                ('b, 'c, 'x) nacser ->
                ('a, 'c, 'x) nacser

  val mk : ('a -> string) -> (string, 'a, 'x) nacser

  type s0
  val nacsString : (string, 'a, s0) nacser ->
                   'a -> string
  type s1
  val nacsFile : (string, 'a, s1) nacser ->
                 string -> 'a effect
end
