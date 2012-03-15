val app : 'a Effect.t -> 'a t Effect.t
val $$ : ('a -> 'b) * 'a t -> 'b t
val $| : 'b * 'a t -> 'b t
