signature FuncCore = sig
  type 'a func
  val map : ('a -> 'b) -> 'a func -> 'b func
end

signature FuncBase = FuncCore

signature FuncExt = sig
  include FuncCore

  val app : 'a Effect.t -> 'a func Effect.t
  val --> : 'a func * ('a -> 'b) -> 'b func
  val <-- : ('a -> 'b) * 'a func -> 'b func
  val $$ : ('a -> 'b) * 'a func -> 'b func
  val lift : ('a -> 'b) -> 'a func -> 'b func
  val $| : 'a * 'b func -> 'a func
end

signature Func = FuncExt
