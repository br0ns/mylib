signature AltCore = sig
  type 'a alt
  val || : 'a alt binop
  val zero : 'a alt
end

signature AltBase = sig
  include AppBase
  include AltCore
  sharing type app = alt
end

signature AltExt = sig
  include AltCore
  val plus : 'a alt -> 'a alt -> 'a alt
  val optional : 'a alt -> 'a option alt
  val merger : 'a alt list -> 'a alt
  val mergel : 'a alt list -> 'a alt
  val guard : bool -> unit alt
end

signature Alt = sig
  include App
  include AltExt
  sharing type app = alt
end
