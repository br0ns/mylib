val insert : t -> elm -> t
val adjust : (elm option -> elm) -> t -> elm -> t
val empty : t
val null : t -> bool
val member : t -> elm -> bool
val remove : t -> elm -> t
val compareElm : elm cmp
val card : t -> int
