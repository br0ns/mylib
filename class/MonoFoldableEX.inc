val foldr1 : elm binop -> t -> elm option
val foldl1 : elm binop -> t -> elm option
val foldrUntil : (elm * 'a -> 'a * bool) -> 'a -> t -> 'a
val foldlUntil : (elm * 'a -> 'a * bool) -> 'a -> t -> 'a
val appl : elm effect -> t effect
val appr : elm effect -> t effect
val apprUntil : elm unpred -> t effect
val applUntil : elm unpred -> t effect
val concatList : t list -> elm list
val concatMap : (elm -> 'a list) -> t -> 'a list
val any : elm unpred -> t unpred
val all : elm unpred -> t unpred
val find : elm unpred -> t -> elm option
val findr : elm unpred -> t -> elm option
val findl : elm unpred -> t -> elm option
val maximumBy : elm cmp -> t -> elm option
val minimumBy : elm cmp -> t -> elm option
val first : t -> elm
val last : t -> elm
