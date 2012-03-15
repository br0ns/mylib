val singleton : elm -> t
val union : t -> t -> t

val viewl : t -> (elm, t) viewl
val viewr : t -> (elm, t) viewr

(* val <| : elm * t -> t *)
(* val \ : t * t -> t *)
(* (\* Does nothing if the element is not in the set *\) *)
(* val remove'    : t -> elm -> t *)

(* val fromList   : elm List.t -> t *)

(* val inter      : t -> t -> t *)
(* val diff       : t -> t -> t *)

(* val subt     : t -> t -> bool *)
(* val equal      : t -> t -> bool *)

(* val compare    : t -> t -> order *)

(* (\* Splits/removes one element from the set and returns the element and the *)
(*  * new set as a tuple *)
(*  *\) *)
(* val split : t -> elm * t *)
val splitOn : t -> elm -> t * elm option * t

(* (\* As split but takes the least/smallest element *\) *)
(* val splitFirst : t -> elm * t *)

(* (\* As split but takes the greatest element *\) *)
(* val splitLast : t -> elm * t *)

(* (\* Some element in the set. May raise Empty *\) *)
(* val some       : t -> elm *)
