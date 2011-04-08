signature Seq = sig
  type 'a t
  val empty : 'a t
  (* val null : 'a t unpred *)
  val singleton : 'a -> 'a t
  val <| : 'a * 'a t -> 'a t
  val |> : 'a t * 'a -> 'a t
  (* val head : 'a t -> 'a *)
  (* val tail : 'a t -> 'a t *)
  (* val last : 'a t -> 'a *)
  (* val init : 'a t -> 'a t *)
  val >< : 'a t * 'a t -> 'a t
  val getl : 'a t -> ('a * 'a t) option
  val getr : 'a t -> ('a * 'a t) option
  val length : 'a t -> int
  val adjust : ('a -> 'a) -> int -> 'a t -> 'a t
  val index : int -> 'a t -> 'a
  val splitAt : int -> 'a t -> 'a t * 'a * 'a t
  (* val foldr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'c *)
  (* val foldl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'c *)
  (* val map : ('a -> 'b) -> 'a t -> 'b t *)
  val rev : 'a t -> 'a t
end

structure List = struct
open List infix <| |> ><
type 'a t = 'a list
val empty = nil
val op<| = op::
fun xs |> x = xs @ [x]
val op>< = op@
fun singleton x = [x]
fun index n xs = nth (xs, n)
fun adjust f n xs =
    case (n, xs) of
      (0, x :: xs) =>
      f x :: xs
    | (n, x :: xs) =>
      x :: adjust f (n - 1) xs
    | _ => raise Subscript

fun getl xs = getItem xs
fun getr xs =
    case getl (rev xs) of
      SOME (x, xs) => SOME (x, rev xs)
    | NONE => NONE

fun splitAt n xs = (List.take (xs, n), List.nth (xs, n), List.drop (xs, n + 1))
end

functor Test (S : Seq) = struct
open S infix |> <| ><

fun repeat n t () =
    let
      fun loop 0 = ()
        | loop n = (t () ; loop (n - 1))
    in
      loop n
    end

fun rev xs =
    let
      fun loop xs ys =
          case getl xs of
            SOME (x, xs) => loop xs (x <| ys)
          | NONE => ys
    in
      loop xs empty
    end

fun fromList xs =
    List.foldr (fn (x, s) => x <| s) empty xs
val ys = List.tabulate (10000, fn n => n)
val xs = fromList ys

(* fun splitAt n xs = *)
(*     let *)
(*       fun loop n (ys, xs) = *)
(*             case getl xs of *)
(*               SOME (x, xs) => *)
(*               if n = 0 then *)
(*                 (ys, x, xs) *)
(*               else *)
(*                 loop (n - 1) (ys |> x, xs) *)
(*             | NONE => raise Subscript *)
(*     in *)
(*       loop n (empty, xs) *)
(*     end *)

fun writeAlt () =
    let
      fun loop 0 _ = xs
        | loop n xs =
          loop (n - 1) (if n mod 2 = 0 then singleton n >< xs else xs >< singleton n)
          (* loop (n - 1) (if n mod 2 = 0 then n <| xs else xs |> n) *)
    in
      loop 10000 xs
    end

fun writeLeft () =
    let
      fun loop 0 _ = xs
        | loop n xs =
          loop (n - 1) (n <| xs)
    in
      loop 10000 xs
    end

fun writeRight () =
    let
      fun loop 0 _ = xs
        | loop n xs =
          loop (n - 1) (xs |> n)
    in
      loop 10000 xs
    end

fun read () =
    let
      fun loop 0 = ()
        | loop n = (if index (n - 1) xs = n - 1 then
                      ()
                    else
                      raise Fail (Int.toString (index (n - 1) xs) ^
                                  " - " ^
                                  Int.toString (n - 1)
                                 )
                  ; loop (n - 1))
    in
      loop 10000
    end

fun adj () =
    let
      fun loop 0 = ()
        | loop n = (adjust (fn x => x) (n - 1) xs
                  ; loop (n - 1))
    in
      loop 10000
    end

fun append () =
    let
      fun loop 0 _ = ()
        | loop n xs = loop (n - 1) (xs >< xs)
    in
      loop 10 (fromList [1,2,3])
    end

val ys = fromList (List.tabulate (1000, fn n => n))
fun cycle () =
    let
      fun loop 0 _ = ()
        | loop n xs =
          let
            val (ys, x, zs) = splitAt (n - 1) xs
            (* val _ = print (Int.toString n ^ "\n") *)
          in
            loop (n - 1) (zs >< (x <| ys))
          end
    in
      loop 1000 ys
    end

fun reverse () = rev xs

val r = 100
val writeAlt = repeat r writeAlt
val writeLeft = repeat r writeLeft
val writeRight = repeat r writeRight
val read = repeat r read
val adj = repeat r adj
val append = repeat 100000 append
val cycle = repeat r cycle
val reverse = repeat 1000 reverse
end

structure TestSeq = Test(Seq)
structure TestList = Test(List)

(* val _ = TestSeq.writeAlt () *)
(* val _ = TestList.read () *)
(* val _ = TestSeq.read () *)
(* val _ = TestList.adj () *)
(* val _ = TestSeq.adj () *)
(* val _ = TestSeq.append () *)
(* val _ = TestSeq.cycle () *)
(* val _ = TestList.cycle () *)
(* val _ = TestSeq.reverse () *)
(* val _ = TestList.reverse () *)

(* local open TestSeq in *)
(* val x = index 6719 xs *)
(* val (x, xs) = indexAdjust (fn x => x) 6719 xs *)
(* end *)

