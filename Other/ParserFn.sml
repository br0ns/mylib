functor ParserFn (Base : ParserBase) :>
        Parser where type ('a, 'b) result = ('a, 'b) Base.result =
struct
open Base
(* type 'a result = ({position : position, *)
(*                    error    : string} Set.t, *)
(*                   'a) Either.t *)
infix 0 |||
infix 1 --- |-- --|
infix 2 >>> --> ??? produce underlies

fun p >>> f = (p --> return o f)
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
fun except t = predicate $ curry op<> t

fun (lexer underlies parser) c = parser $ lexer c

fun choice [p] = p
  | choice (p :: ps) = p ||| choice ps
  | choice _ = (any |-- fail) ??? "at least one parser in choice"

fun cons p = p >>> op::

fun link ps = foldr (cons o op---) (return nil) ps
fun count 0 p = return nil
  | count n p = cons (p --- count (n - 1) p)
fun many p c = (cons (try p --- many p) ||| return nil) c
fun many1 p = cons (p --- many p)
fun maybe p = p >>> SOME ||| return NONE
fun between l r p = l |-- p --| r
fun followedBy p = lookAhead p produce ()
fun manyTill p stop = stop produce nil |||
                      cons (p --- manyTill p stop)
fun sepBy1 p sep = cons (p --- many (sep |-- p))
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
          (oper --- scan) >>> (fn (f, rhs) => f (lhs, rhs)) ||| return lhs
    in
      scan
    end
fun chainr p oper x = chainr1 p oper ||| return x

structure Text =
struct
fun char c = token c ??? ("'" ^ str c ^ "'")

(* I actually wrote this - refactor please *)
fun string s =
    let
      fun loop nil = return nil
        | loop (c :: cs) = cons (char c --- loop cs) ???
                           ("'" ^ str c ^ "' in \"" ^ s ^ "\"")
    in
      loop (explode s) >>> implode
    end

fun oneOf cs = foldr op||| fail $ List.map token cs
fun noneOf cs = foldr op||| fail $ List.map (predicate o curry op<>) cs
fun space c = (oneOf $ explode " \n\t\r" ??? "space") c
fun spaces c = (many space >>> length) c
fun newline c = (token #"\n" ??? "new line") c
fun tab c = (token #"\t" ??? "tab") c
fun upper c = (predicate Char.isUpper ??? "upper case letter") c
fun lower c = (predicate Char.isLower ??? "lower case letter") c
fun alphaNum c = (predicate Char.isAlphaNum ??? "alphanumeric character") c
fun letter c = (predicate Char.isAlpha ??? "letter") c
fun word c = (many1 letter >>> implode ??? "word") c
fun line c = (many $ except #"\n" >>> implode --| newline ??? "line") c
fun digit c = (predicate Char.isDigit ??? "digit") c
fun natural c = (many1 digit produce ()) c
fun whitespace c = ((many $ oneOf $ explode " \n\t\r") produce ()) c
end

structure Lex =
struct
fun lexeme p = p --| Text.whitespace

fun symbol s = lexeme $ Text.string s

fun identifier {head, tail} =
    lexeme ((head --- many tail) >>> op::)

fun letter c = lexeme Text.letter c

fun word c = lexeme Text.word c

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
      (
       (many1 Text.digit) >>> (foldl (fn (d, n) => ord d - 48 + 10 * n) 0)
      )
      c
end

structure Parse =
struct
fun run p r s = fst $ parse p r s

fun vector p v =
    fst $ parse p VectorSlice.getItem $ VectorSlice.full v

fun string p s =
    fst $ parse p Substring.getc $ Substring.full s

fun list p l = fst $ parse p List.getItem l

fun lazyList p l = fst $ parse p LazyList.getItem l

fun file p f = lazyList p $ LazyList.fromFile f

fun testVector show p v =
    test show p VectorSlice.getItem $ VectorSlice.full v

fun testString p s =
    test (fn c => "'" ^ str c ^ "'") p Substring.getc $ Substring.full s

fun testList show p l =
    test show p List.getItem l

fun testLazyList show p l =
    test show p LazyList.getItem l

fun testFile p f =
    testLazyList (fn c => "'" ^ str c ^ "'") p $ LazyList.fromFile f

end
end
