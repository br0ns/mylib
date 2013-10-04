signature RandomAccessList = 
sig

    type 'a RList

    val empty : 'a RList
    val isEmpty : 'a RList -> bool

    val cons : 'a * 'a RList -> 'a RList
    val head : 'a RList -> 'a (* Raises Empty if the list is empty *)
    val tail : 'a RList -> 'a RList (* Raise Empty if the list is empty *)

    (* raise Subscript if the index is out of bounds *)
    val lookup : int * 'a RList -> 'a
    val update : int * 'a * 'a RList -> 'a RList

end
