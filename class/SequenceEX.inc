(* See also: Func, Idiom, Alt, Monad, MonadP, Foldable, Enumerable, Unfoldable
 *)

val head : 'a t -> 'a
val tail : 'a t unop
val split : 'a t -> 'a * 'a t
val init : 'a t unop
val splitLast : 'a t -> 'a * 'a t
val singleton : 'a -> 'a t
val !! : 'a t * int -> 'a
val append : 'a t -> 'a t -> 'a t
val delete : 'a t -> int -> 'a t

val viewl : 'a t -> ('a, 'a t) viewl
val viewr : 'a t -> ('a, 'a t) viewr

val cons : 'a -> 'a t unop
val snoc : 'a -> 'a t unop
val lookup : 'a t -> int -> 'a option
val update : 'a t -> int -> 'a -> 'a t

val rev : 'a t unop
val take : 'a t * int -> 'a t
val drop : 'a t * int -> 'a t
val takeDrop : 'a t * int -> 'a t * 'a t
val splitAt : int -> 'a t -> 'a t * 'a * 'a t
val concat : 'a t t -> 'a t
val revAppend : 'a t binop
val tabulate : int * (int -> 'a) -> 'a t
val collate : 'a cmp -> 'a t cmp

val sort : 'a cmp -> 'a t unop
val shuffle : 'a t unop
val allPairs : 'a t -> ('a * 'a) t
val allSplits : 'a t -> ('a t * 'a t) t
val consAll : 'a -> 'a t t -> 'a t t
val concatMap : ('a -> 'b t) -> 'a t -> 'b t
val slice : ('a t * int option * int option) -> 'a t
val groupBy : 'a binpred -> 'a t -> 'a t t
val group : ''a t -> ''a t t
val tokens : 'a unpred -> 'a t -> 'a t t
val fields : 'a unpred -> 'a t -> 'a t t
val power : 'a t -> 'a t t
val permutations : 'a t -> 'a t t
val inits : 'a t -> 'a t t
val tails : 'a t -> 'a t t
val subsequences : 'a t -> 'a t t

val intersperse : 'a -> 'a t -> 'a t
val transpose : 'a t t unop
val scanl : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b t
val scanl1 : 'a binop -> 'a t -> 'a t option
val scanlWhile : ('a * 'b -> 'b * bool) -> 'b -> 'a t -> 'b t
val scanr : ('a * 'b -> 'b) -> 'b -> 'a t -> 'b t
val scanr1 : 'a binop -> 'a t -> 'a t option
val scanrWhile : ('a * 'b -> 'b * bool) -> 'b -> 'a t -> 'b t
val mapAccumL : ('a * 'c -> 'b * 'c) -> 'c -> 'a t -> 'b t * 'c
val mapAccumR : ('a * 'c -> 'b * 'c) -> 'c -> 'a t -> 'b t * 'c
val replicate : int -> 'a -> 'a t
val takeWhile : 'a unpred -> 'a t -> 'a t
val dropWhile : 'a unpred -> 'a t -> 'a t
val partition : 'a unpred -> 'a t -> 'a t * 'a t
val span : 'a unpred -> 'a t -> 'a t * 'a t
val break : 'a unpred -> 'a t -> 'a t * 'a t
val stripPrefix : ''a t -> ''a t -> ''a t option
val isPrefixOf : ''a t -> ''a t unpred
val isSuffixOf : ''a t -> ''a t unpred
val isInfixOf : ''a t -> ''a t unpred
val memberIndex : ''a -> ''a t -> int option
val memberIndices : ''a -> ''a t -> int t
val findIndex : 'a unpred -> 'a t -> int option
val findIndices : 'a unpred -> 'a t -> int t
val lines : string -> string t
val unlines : string t -> string
val words : string -> string t
val unwords : string t -> string
val nub : ''a t unop
val somes: 'a option t -> 'a t

val zip : 'a t * 'b t -> ('a * 'b) t
val zipWith : ('a * 'b -> 'c) -> 'a t * 'b t -> 'c t
val unzip : ('a * 'b) t -> 'a t * 'b t
val zip3 : 'a t * 'b t * 'c t -> ('a * 'b * 'c) t
val zipWith3 : ('a * 'b * 'c -> 'd) -> 'a t * 'b t * 'c t -> 'd t
val unzip3 : ('a * 'b * 'c) t -> 'a t * 'b t * 'c t
val zip4 : 'a t * 'b t * 'c t * 'd t -> ('a * 'b * 'c * 'd) t
val zipWith4 : ('a * 'b * 'c * 'd -> 'e) -> 'a t * 'b t * 'c t * 'd t -> 'e t
val unzip4 : ('a * 'b * 'c * 'd) t -> 'a t * 'b t * 'c t * 'd t
val zip5 : 'a t * 'b t * 'c t * 'd t * 'e t -> ('a * 'b * 'c * 'd * 'e) t
val zipWith5 : ('a * 'b * 'c * 'd * 'e -> 'f) ->
               'a t * 'b t * 'c t * 'd t * 'e t -> 'f t
val unzip5 : ('a * 'b * 'c * 'd * 'e) t -> 'a t * 'b t * 'c t * 'd t * 'e t
