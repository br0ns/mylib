val plus : t -> t -> t
val merger : t list -> t
val mergel : t list -> t
val mapPartial : (elm -> elm option) -> t -> t
val keep : elm unpred -> t unop
val reject : elm unpred -> t unop
