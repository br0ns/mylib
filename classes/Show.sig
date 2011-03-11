signature ShowI = sig
  type 'a t
  val show : 'a t -> string
end

signature ShowO = sig
  include ShowI

  val println : 'a t -> unit
end

signature Show = sig
  structure Show : ShowI
end
