signature Read = sig
  type t
  include "ReadIN.inc"
end

signature ReadEX = sig
  type t
  include "ReadEX.sig"
end
