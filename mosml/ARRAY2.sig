signature ARRAY2 =
sig
  type 'a array

  val dimensions : 'a array -> int * int
  val sub : 'a array * int * int -> 'a
end
