structure Timer =
struct
open Timer
fun checkCPUTimer timer =
    case Timer.checkCPUTimer timer of
      {usr, sys, ...} => {usr = usr, sys = sys}
end
