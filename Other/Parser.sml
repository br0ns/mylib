structure Parser =
ParserFn(
struct
infix 0 |||
infix 1 --- |-- --|
infix 2 >>> --> ???

datatype either = datatype Either.t

type ('a, 'x) reader = ('a, 'x) StringCvt.reader
type position = int
type 'x state = 'x * 'x * position
fun position (_, _, p) = p
fun stream (_, s, _, _) = s
fun streamBefore (s, _, _) = s

datatype error = Expected of string
               | Unexpected

type ('a, 'x) consumer = 'x state ->
                         (('x state * error) list,
                          'a) either * 'x state * int

type ('a, 'b, 'x) parser = ('a, 'x) consumer -> ('b, 'x) consumer

type ('a, 'b) result = ({position : position,
                         error    : string} list,
                        'b) Either.t

fun expect err errs =
    Left (err :: List.filter (fn (_, Expected _) => false
                               | _ => true) errs
         )

fun (p ??? expected) con state =
    case p con state of
      (err as (Left errs, state', n)) =>
      if n = 0 then
        (expect (state', Expected expected) errs, state', n)
      else
        err
    | x => x

fun fail con state = (Left [(state, Unexpected)], state, 0)

fun getState con state = (Right state, state, 0)
fun setState state' con _ = (Right (), state', 0)

fun any con state = con state
fun notFollowedBy p con state =
    case p con state of
      (Right _, _, _) => (Left [(state, Unexpected)], state, 0)
    | (Left _, _, _)  => (Right (), state, 0)

fun (p1 ||| p2) con state =
    case p1 con state of
      (err as (Left errs, state', n)) =>
      if n = 0 then
        case p2 con state of
          (Left errs', state'', n') =>
          (Left $ errs @ errs', state'', n')
        | x => x
      else
        err
    | x => x

fun try p con state =
    case p con state of
      (Left errs, _, _) => (Left errs, state, 0)
    | x => x

fun return x con state = (Right x, state, 0)

fun (p --> f) con state =
    case p con state of
      (Right x, state', n) =>
      let
        val (x, state'', n') = (f x) con state'
      in
        (x, state'', n + n')
      end
    | (Left e, state', n) => (Left e, state', n)

fun parse p show r s =
    let
      fun con (_, s, p) =
          case r s of
            SOME (x, s') => (Right x, (s, s', p + 1), 1)
          | NONE => (Left nil, (s, s, p), 0)
      val state = (s, s, 1)
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
          | SOME (x, _) => show x

      fun errs nil = IntMap.empty
        | errs ((state, error) :: es) =
          let
            open IntMap
            val p = position state
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
        (Left errs, (s, _, _), n) =>
        (Left $ err errs,
         s)
      | (Right x, (_, s', _), n) => (Right x, s')
    end

fun scan p r s =
    case parse p (const "") r s of
      (Left _, _) => NONE
    | (Right x, s') => SOME (x, s')

end)
