signature PointedCore = sig
  type 'a pointed
  val return : 'a -> 'a pointed
end

signature PointedBase = PointedCore

signature PointedExt = sig
  include PointedCore
end

signature Pointed = PointedExt
