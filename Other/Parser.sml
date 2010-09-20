structure Parser =
ParserFn(
struct
infix 0 |||
infix 1 --- |-- --|
infix 2 >>> --> ???

datatype either = datatype Either.t

type ('a, 'x) reader = ('a, 'x) StringCvt.reader
type position = int
type 'x state = 'x * 'x * position * int
fun position (_, _, p, _) = p
fun parsed (_, _, _, n) = n
fun stream (_, s, _, _) = s
fun streamBefore (s, _, _, _) = s
fun renew (_, s, n, _) = (s, s, n, 0)

datatype error = Expected of string
               | Unexpected

type ('a, 'x) consumer = 'x state ->
                         (('x state * error) list,
                          'a) either * 'x state

type ('a, 'b, 'x) parser = ('a, 'x) consumer -> ('b, 'x) consumer

type 'a result = ({position : position,
                   error    : string} list,
                  'a) Either.t

(*
 * val ??? : ('a, 'b, 'x) parser * string -> ('a, 'b, 'x) parser
 * val unexpected : 'a -> ('a, 'b, 'x) parser
 * val fail : string -> ('a, 'b, 'x) parser
 * val getState : ('a, 'x state, 'x) parser
 * val setState : 'x state -> ('a, unit, 'x) parser
 * * val getPosition : ('a, position, 'x) parser
 * * val setPosition : position -> ('a, unit, 'x) parser
 * val any : ('a, 'a, 'x) parser
 * val ||| : ('a, 'b, 'x) parser * ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
 * val try : ('a, 'b, 'x) parser -> ('a, 'b, 'x) parser
 * val --> : ('a, 'b, 'x) parser * ('b -> ('a, 'c, 'x) parser) -> ('a, 'c, 'x) parser
 * val return : 'b -> ('a, 'b, 'x) parser
 * val parse : ('a, 'b, 'x) parser -> ('a, 'x) reader -> 'x -> ('a, 'b) result
 *)

fun expect err errs =
    Left (err :: List.filter (fn (_, Expected _) => false
                               | _ => true) errs
         )

fun (p ??? expected) con state =
    case p con state of
      (res as (Left err, state')) =>
      if parsed state' = 0 then
        (expect (state, Expected expected) err, state')
      else
        res
    | x => x

fun expected s con state = (Left [(state, Expected s)], state)
fun fail con state = (Left [(state, Unexpected)], state)

fun getState con state = (Right state, state)
fun setState state' con _ = (Right (), state')

fun any con state = con state

fun (p1 ||| p2) con state =
    case p1 con state of
      (Left errs, state') =>
      if position state = position state' then
        Arrow.first (Arrow.left (errs \< op@)) (p2 con state)
      else
        (Left errs, state')
    | x => x

fun try p con state =
    case p con state of
      (Left errs, _) => (Left errs, renew state)
    | x => x

fun return x con state = (Right x, state)

fun (p --> f) con state =
    case p con state of
      (Right x, state') => (f x) con state'
    | (Left errs, state') => (Left errs, state')

fun parse p show r s =
    let
      fun con (_, s, n, _) =
          case r s of
            SOME (x, s') => (Right x, (s, s', n + 1, 1))
          | NONE => (Left nil, (s, s, n, 0))
      val state = (s, s, 1, 0)
      (* fun tok n = *)
      (*     let *)
      (*       fun loop 1 (SOME (x, _)) = SOME x *)
      (*         | loop n (SOME (_, s)) = *)
      (*           loop (n - 1) (r s) *)
      (*         | loop _ NONE = NONE *)
      (*     in *)
      (*       loop n (r s) *)
      (*     end *)

      fun tok state =
          case r (streamBefore state) of
            NONE => "end of input"
          | SOME (x, _) => show x ^ "(" ^ Show.int (parsed state) ^ ")"

      fun errs nil = IntMap.empty
        | errs ((state, error) :: es) =
          let
            open IntMap
            val p = position state - parsed state
            val m = errs es
          in
            modify (fn (t, exs) => (t, Set.insert exs error)) m p
            handle Domain => singleton (p, (tok state, Set.singleton error))
          end

      fun err es =
          let
            val m = errs es
            val ps = IntMap.toList m
            fun showe Unexpected = ""
              | showe (Expected e) = e
          in
            map (fn (p, (t, es)) =>
                    {position = p,
                     error = "Unexpected " ^ t ^ ", expected one of " ^
                             Show.list showe
                                       (List.filter
                                          (fn Expected _ => true | _ => false)
                                          (Set.toList es)
                                       )
                    }
                ) ps
          end

      (* fun err (s, e) = *)
      (*     {position = position s, *)
      (*      error = *)
      (*      (\* (fn Expected e => "Expected " ^ e *\) *)
      (*      (\*   | Unexpected => "Unexpected " ^ *\) *)
      (*      (\*                   (case tok s of *\) *)
      (*      (\*                      SOME x => show x *\) *)
      (*      (\*                    | NONE   => "end of input") *\) *)
      (*      (\* ) e *\) *)
      (*     } *)
    in
      case p con state of
        (Left errs, (s, _, n, _)) =>
        (Left $ err errs,
         s)
      | (Right x, (_, s', n, _)) => (Right x, s')
    end
end)
