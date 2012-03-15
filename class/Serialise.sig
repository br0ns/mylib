signature Serialise =
sig
  type t
  include "SerialiseIN.sig"
end

signature SerialiseEX =
sig
  type t
  include "SerialiseEX.sig"
end
