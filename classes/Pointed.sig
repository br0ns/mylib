signature PointedI = sig
  type 'a t
  val return : 'a -> 'a t
end

signature PointedO = sig
  include PointedI
end

signature Pointed = sig
  structure Pointed : PointedI
end
