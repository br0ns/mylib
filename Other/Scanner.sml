structure Scanner =
ParserFn(
struct
infix 0 |||
infix 1 --- |-- --|
infix 2 >>> --> ???

type ('a, 'x) reader = ('a, 'x) StringCvt.reader
type 'x state = 'x
type ('a, 'x) consumer = 'x state -> ('a * 'x state) option
type ('a, 'b, 'x) parser = ('a, 'x) consumer -> ('b, 'x) consumer
type ('a, 'b) result = 'b option

fun (p --> f) con state =
    case p con state of
      SOME (x, state') => (f x) con state'
    | NONE => NONE
fun return x con state = SOME (x, state)
fun fail _ _ = NONE
fun (p1 ||| p2) con state =
    case p1 con state of
      NONE => p2 con state
    | x => x
fun getState con state = SOME (state, state)
fun setState state' con state = SOME ((), state')

fun (p ??? s) = p
fun any con state = con state
fun try p = p
fun parse p show con state =
    case p con state of
      SOME (x, state') => (SOME x, state')
    | NONE => (NONE, state)
fun scan p = p
end)
