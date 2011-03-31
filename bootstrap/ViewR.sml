structure ViewR = struct
datatype ('a, 'b) t = nilr | ::> of 'b * 'a
end
