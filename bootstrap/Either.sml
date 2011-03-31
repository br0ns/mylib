structure Either = struct
datatype ('a, 'b) t = Left of 'a | Right of 'b
end
