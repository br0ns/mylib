functor ParserFn (Base : ParserBase) :>
        Parser where type ('a, 'b) result = ('a, 'b) Base.result =
struct
open Base
(* type 'a result = ({position : position, *)
(*                    error    : string} Set.t, *)
(*                   'a) Either.t *)
infix 0 |||
infix 1 --- |-- --|
infix 2 >>> --> ??? produce

fun map f p = (p --> return o f)
fun (p1 --- p2) = p1 --> (fn a => p2 --> return o pair a)
fun (p1 --| p2) = p1 --> (fn x => p2 --> (fn _ => return x))
fun (p1 |-- p2) = p1 --> (fn _ => p2 --> (fn x => return x))
fun p produce x = p |-- return x

fun predicate p =
    try (any -->
             (fn x =>
                 if p x then
                   return x
                 else
                   fail
             )
        )

fun lookAhead p =
    getState --> (fn state =>
    p --> (fn x =>
      setState state |-- return x
    ))

fun eof c = (notFollowedBy any ??? "end of stream") c

fun token t = predicate $ curry op= t

fun (lexer >>> parser) c = parser $ lexer c

fun choice [p] = p
  | choice (p :: ps) = p ||| choice ps
  | choice _ = (any |-- fail) ??? "at least one parser in choice"
fun link ps = foldr (map op:: o op---) (return nil) ps
fun count 0 p = return nil
  | count n p = map op:: (p --- count (n - 1) p)
fun many p c = (map op:: $ (try p --- many p) ||| return nil) c
fun many1 p = map op:: (p --- many p)
fun maybe p = map SOME p ||| return NONE
fun between l r p = l |-- p --| r
fun followedBy p = lookAhead p produce ()
fun manyTill p stop = stop produce nil |||
                      map op:: (p --- manyTill p stop)
fun sepBy1 p sep = map op:: (p --- many (sep |-- p))
fun sepBy p sep = sepBy1 p sep ||| return nil
fun endBy p e = many (p --| e)
fun endBy1 p e = many1 (p --| e)
fun sepEndBy p sep = sepBy p sep --| maybe sep
fun sepEndBy1 p sep = sepBy1 p sep --| maybe sep

fun chainl1 p oper =
    let
      fun rest lhs =
          (oper --- p) --> (fn (f, rhs) => rest $ f (lhs, rhs)) ||| return lhs
    in
      p --> rest
    end
fun chainl p oper x = chainl1 p oper ||| return x

fun chainr1 p oper =
    let
      fun scan c = (p --> rest) c
      and rest lhs =
          map (fn (f, rhs) => f (lhs, rhs)) (oper --- scan) ||| return lhs
    in
      scan
    end
fun chainr p oper x = chainr1 p oper ||| return x

structure Text =
struct
fun char c = try (token c) ??? ("'" ^ str c ^ "'")

(* I actually wrote this - refactor please *)
fun string s =
    let
      fun loop nil = return nil
        | loop (c :: cs) = map op:: (char c --- loop cs) ???
                           ("'" ^ str c ^ "' in \"" ^ s ^ "\"")
    in
      map implode $ loop (explode s)
    end

fun oneOf cs = foldr op||| fail $ List.map token cs
fun noneOf cs = foldr op||| fail $ List.map (predicate o curry op<>) cs
fun space c = (oneOf $ explode " \n\t\r" ??? "space") c
fun spaces c = (map length $ many space) c
fun newline c = (token #"\n" ??? "new line") c
fun tab c = (token #"\t" ??? "tab") c
fun upper c = (predicate Char.isUpper ??? "upper case letter") c
fun lower c = (predicate Char.isLower ??? "lower case letter") c
fun alphaNum c = (predicate Char.isAlphaNum ??? "alphanumeric character") c
fun letter c = (predicate Char.isAlpha ??? "letter") c
fun digit c = (predicate Char.isDigit ??? "digit") c
fun natural c = (many1 digit produce ()) c
fun whitespace c = ((many $ oneOf $ explode " \n\t\r") produce ()) c
end

structure Lex =
struct
fun lexeme p = p --| Text.whitespace

fun symbol s = lexeme $ Text.string s

fun keywords ks =
    foldr op||| fail $ List.map (fn (k, a) => try (symbol k) produce a) ks

fun parens p = between (symbol "(") (symbol ")") p
fun braces p = between (symbol "{") (symbol "}") p
fun angles p = between (symbol "<") (symbol ">") p
fun brackets p = between (symbol "[") (symbol "]") p
fun semi c = symbol ";" c
fun colon c = symbol ":" c
fun comma c = symbol "," c
fun dot c = symbol "." c
fun semiSep p = sepBy p (symbol ";")
fun semiSep1 p = sepBy1 p (symbol ";")
fun commaSep p = sepBy p (symbol ",")
fun commaSep1 p = sepBy1 p (symbol ",")

fun natural c =
    lexeme
      (map (foldl (fn (d, n) => ord d - 48 + 10 * n) 0)
           (many1 Text.digit)
      )
      c
end

structure Parse =
struct
fun vector p show v =
    fst $ parse p show VectorSlice.getItem (VectorSlice.full v)
fun vectorFull p = vector (p --| eof)

fun run p show r s = fst $ parse p show r s
fun full p = run (p --| eof)

fun string p s = vector p (fn c => "'" ^ str c ^ "'") s
fun stringFull p s = vectorFull p (fn c => "'" ^ str c ^ "'") s

fun list p show l = fst $ parse p show List.getItem l
fun listFull p = list (p --| eof)

fun file p f = string p $ TextIO.readFile f
fun fileFull p = file (p --| eof)
end
end
