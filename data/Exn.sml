structure Exn : EXN = struct
   open Exn Ext.Exn
   val name = BasisGeneral.exnName
   val message = BasisGeneral.exnMessage
   fun apply f x = Sum.INR (f x) handle e => Sum.INL e
   fun eval th = apply th ()
   fun throw e = raise e
   fun reflect s = Sum.sum (throw, Fn.id) s
   fun try (th, fv, fe) = Sum.sum (fe, fv) (eval th)
   fun after (th, ef) = try (th, Effect.past ef, throw o Effect.past ef)
   val finally = after
end
