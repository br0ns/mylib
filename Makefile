all :
	sed "s/.*and type exn = exn//" Extensions/General.sig > mosml/General.sig
	cat mosml/GENERAL.sig \
      mosml/VECTOR_SLICE.sig \
      mosml/LIST.sig \
      mosml/General.sig \
      mosml/TEXT_IO.sig \
      mosml/MATH.sig \
      mosml/STRING.sig \
      mosml/Random.sig \
\
      mosml/Random.sml \
      mosml/Timer.sml \
      mosml/String.sml \
      mosml/Substring.sml \
      mosml/VectorSlice.sml \
\
      Extensions/General.sml \
      Extensions/List.sig \
      Extensions/List.sml \
      Extensions/TextIO.sig \
      Extensions/TextIO.sml \
      Extensions/Math.sig \
      Extensions/Math.sml \
      Extensions/String.sig \
      Extensions/String.sml \
\
      Other/Lazy.sig \
      Other/Lazy.sml \
      Other/Debug.sig \
      Other/Debug.sml \
      Other/Either.sig \
      Other/Either.sml \
      Other/Arrow.sig \
      Other/Arrow.sml \
      Other/LazyList.sig \
      Other/LazyList.sml \
      Other/Benchmark.sig \
      Other/Benchmark.sml \
      Other/Show.sig \
      Other/Show.sml \
      Other/Pair.sig \
      Other/Pair.sml \
\
      Other/Pretty.sig \
      Other/Pretty.sml \
      Other/Layout.sig \
      Other/Layout.sml \
\
      DataStructures/Ordered.sig \
\
      DataStructures/Map/Map.sig \
      DataStructures/Map/ListMap.sml \
      DataStructures/Map/Map.sml \
\
      DataStructures/OrderedMap/OrderedMap.sig \
      DataStructures/OrderedMap/ListOrderedMapFn.sml \
      DataStructures/OrderedMap/UnbalancedOrderedMapFn.sml \
      DataStructures/OrderedMap/OrderedMapFn.sml \
      DataStructures/OrderedMap/Dictionary.sml \
      DataStructures/OrderedMap/IntMap.sml \
      DataStructures/OrderedMap/CharMap.sml \
\
      DataStructures/OrderedSet/OrderedSet.sig \
      DataStructures/OrderedSet/UnbalancedOrderedSetFn.sml \
      DataStructures/OrderedSet/TrieOrderedSetFn.sml \
      DataStructures/OrderedSet/RedBlackOrderedSetFn.sml \
      DataStructures/OrderedSet/OrderedSetFn.sml \
      DataStructures/OrderedSet/StringSet.sml \
      DataStructures/OrderedSet/IntSet.sml \
      DataStructures/OrderedSet/CharSet.sml \
\
      DataStructures/Set/Set.sig \
      DataStructures/Set/ListSet.sml \
      DataStructures/Set/Set.sml \
\
      DataStructures/Multiset/Multiset.sig \
\
      DataStructures/Heap/Heap.sig \
      DataStructures/Heap/PairingHeapFn.sml \
      DataStructures/Heap/HeapFn.sml \
      DataStructures/Heap/IntMinHeap.sml \
      DataStructures/Heap/IntMaxHeap.sml \
\
      DataStructures/Queue/Queue.sig \
      DataStructures/Queue/Deque.sig \
\
      DataStructures/Tree/Tree.sig \
      DataStructures/Tree/PlainTreeFn.sml \
      DataStructures/Tree/Tree.sml \
\
      Other/Parsing.sig \
      Other/Parsing.sml \
      Other/JSON.sig \
      Other/JSON.sml \
\
      Algorithms/ListSort/ListSort.sig \
      Algorithms/ListSort/QuickSortList.sml \
      Algorithms/ListSort/ListSort.sml \
      Algorithms/TopologicalSort/TopologicalSort.sig \
      Algorithms/TopologicalSort/TopologicalSort.sml \
\
      TopLevel.sml > MyLib.sml

	mosmlc -c -P full \
      Random.ui \
      -toplevel MyLib.sml
	rm MyLib.sml