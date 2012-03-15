val foldr1 : 'a binop -> 'a t -> 'a option
val foldl1 : 'a binop -> 'a t -> 'a option
val foldrWhile : ('a * 'b -> 'b * bool) -> 'b -> 'a t -> 'b
val foldlWhile : ('a * 'b -> 'b * bool) -> 'b -> 'a t -> 'b
val appl : 'a effect -> 'a t effect
val appr : 'a effect -> 'a t effect
val applWhile : ('a -> bool) -> 'a t effect
val apprWhile : ('a -> bool) -> 'a t effect
val concatFoldable : 'a list t -> 'a list
val concatList : 'a t list -> 'a list
val conjoin : bool t unpred
val disjoin : bool t unpred
val any : 'a unpred -> 'a t unpred
val all : 'a unpred -> 'a t unpred
val find : 'a unpred -> 'a t -> 'a option
val findr : 'a unpred -> 'a t -> 'a option
val findl : 'a unpred -> 'a t -> 'a option
val member : ''a -> ''a t unpred
val notMember : ''a -> ''a t unpred
val maximumBy : 'a cmp -> 'a t -> 'a option
val minimumBy : 'a cmp -> 'a t -> 'a option
val intSum : int t -> int
val realSum : real t -> real
val intProduct : int t -> int
val realProduct : real t -> real
val leftmost  : 'a option t -> 'a option
val rightmost : 'a option t -> 'a option
val first : 'a t -> 'a
val last : 'a t -> 'a
