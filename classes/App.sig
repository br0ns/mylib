signature AppCore = sig
  type 'a app
  val ** : ('a -> 'b) app * 'a app -> 'b app
end

signature AppBase = sig
  include PointedCore
  include AppCore
  sharing type pointed = app
end

signature AppExt = sig
  include AppCore

  val >> : 'a app * 'b app -> 'b app
  val << : 'a app * 'b app -> 'a app
  val allPairs : 'a app -> 'b app -> ('a * 'b) app
  val lift2 : ('a -> 'b -> 'r) -> 'a app -> 'b app -> 'r app
  val lift3 : ('a -> 'b -> 'c -> 'r) -> 'a app -> 'b app -> 'c app -> 'r app
  val lift4 : ('a -> 'b -> 'c -> 'd -> 'r) ->
              'a app -> 'b app -> 'c app -> 'd app -> 'r app
  val mergeBy : ('a * 'a -> 'a) -> 'a app list -> 'a app
end

signature App = sig
  include Func
  include Pointed
  include AppExt
  sharing type func = pointed = app
end
