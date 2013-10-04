(* The BinaryRandomAccessList structure. 
 * This is a type of functional array that guarantees logarithmic access
 * and update.
 *)
structure BinaryRandomAccessList :> RandomAccessList= 
struct

  (* The 'a Tree datatype *)
  datatype 'a Tree = LEAF of 'a | NODE of int * 'a Tree * 'a Tree
  (* The Digit datatype *)
  datatype 'a Digit = ZERO | ONE of 'a Tree
  (* The 'a RList type as defined in the signature *)
  type 'a RList = 'a Digit list

  (* Exceptions for head/tail and lookup/update *)
  exception Empty
  exception Subscript

  (* The Empty list *)
  val empty = []
  (* If a list is empty, then the RList is empty *)
  fun isEmpty ts = null ts

  (* size ts : 'a Tree = 1 if ts is a leaf, otherwise 
   * size NODE (w, t1, t2) : 'a Tree = w : int *)
  fun size (LEAF x) = 1
    | size (NODE (w, t1, t2)) = w

  (* link (t1 : 'a Tree, t2 : 'a Tree) = t : Tree
   * Where size t = size t1 + size t2, the left tree is t1, and the right tree
   * is t2.
   *)
  fun link(t1, t2) = NODE(size t1 + size t2, t1, t2)

  (* consTree (t : 'a Tree, ts : 'a RList) = rs : 'a RList
   * Where rs is an 'a RList containing the tree t and the trees in ts.
   *) 
  fun consTree (t, []) = [ONE t]
    | consTree (t, ZERO :: ts) = ONE t :: ts
    | consTree (t1, ONE t2 :: ts) = ZERO :: consTree (link (t1, t2), ts)

  (* unconsTree rs : 'a RList = (t : 'a Tree, rs' : 'a RList)
   * Where t is the first tree in rs and rs' is the rest of the 'a RList.
   *)
  fun unconsTree [] = raise Empty
    | unconsTree [ONE t] = (t, [])
    | unconsTree (ONE t :: ts) = (t, ZERO :: ts)
    | unconsTree (ZERO :: ts) = 
      let val (NODE (_, t1, t2), ts') = unconsTree ts
      in (t1, ONE t2 :: ts') end

  (* cons (x : 'a, ts : 'a RList) = rs 'a RList
   * Where rs is a binary random access list and the first element of rs is now
   * x.
   *)
  fun cons (x, ts) = consTree (LEAF x, ts)
  
  (* head rs : 'a RList = x : 'a where x is the first element in rs. *)
  fun head ts = let val (LEAF x, _) = unconsTree ts in x end

  (* tail rs : 'a RList = rs' : 'a RList where rs' is a binary random access
   * list and rs' consists of all the elements of rs except the first.
   *)
  fun tail ts = let val (_, ts') = unconsTree ts in ts' end

  (* lookupTree (i : int, t : 'a Tree) = x : 'a
   * Where x is the ith element in tree t where since t is a leaf complete
   * binary tree, x is the ith leaf from the left, starting at 0.
   *)
  fun lookupTree (0, LEAF x) = x
    | lookupTree (i, LEAF x) = raise Subscript
    | lookupTree (i, NODE(w, t1, t2)) = 
      if i < w div 2 then lookupTree (i, t1)
      else lookupTree (i - w div 2, t2)

  (* updateTree (i : int, x : 'a, t : 'a Tree = t' : 'a Tree
   * Where the elements of t' are the same as t, except the element in the ith
   * leaf has been replaced by x.
   *)
  fun updateTree (0, y, LEAF x) = LEAF y
    | updateTree (i, y, LEAF x) = raise Subscript
    | updateTree (i, y, NODE (w, t1, t2)) = 
      if i < w div 2 then NODE(w, updateTree (i, y, t1), t2)
      else NODE(w, t1, updateTree (i - w div 2, y, t2))

  (* lookup (i : int, rs : 'a RList) = x : 'a
   * Where x is the ith element in rs, a binary random access list.
   *)
  fun lookup (i, []) = raise Subscript
    | lookup (i, ZERO :: ts) = lookup (i, ts)
    | lookup (i, ONE t :: ts) = 
      if i < size t then lookupTree (i, t) else lookup (i - size t, ts)

  (* update (i : int, x : 'a, rs : 'a RList) = rs' : 'a RList
   * Where the element in the ith index is now x.
   *)
  fun update (i, y, []) = raise Subscript
    | update (i, y, ZERO :: ts) = ZERO :: update (i, y, ts)
    | update (i, y, ONE t :: ts) = 
      if i < size t then ONE (updateTree (i, y, t)) :: ts
      else ONE t :: update (i - size t, y, ts)

end
