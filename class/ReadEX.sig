val read : string -> t
val readFromFile : string -> t option
val readFromStdIn : t option thunk
val reads : string -> t list
val readsFromFile : string -> t list
val readsFromStdIn : t list thunk
