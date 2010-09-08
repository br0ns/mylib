signature TextIO =
sig
  include TEXT_IO

  val println : string -> unit
  val readFile : string -> string
  val writeFile : string -> string -> unit
  val appendFile : string -> string -> unit
end
