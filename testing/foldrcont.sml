val xs = List.tabulate (1000000, const 1)

fun foldc f b xs = foldl (fn (x, k) => fn b => k $ f (x, b)) id xs b

val f = foldl op+ 0
val g = foldr op+ 0
val h = foldc op+ 0

fun rep f = (List.tabulate (100, fn _ => f xs) ; ())

;Benchmark.start ();
;rep f;
;Benchmark.stopAndPrint "foldl";

;Benchmark.start ();
;rep g;
;Benchmark.stopAndPrint "foldr";

;Benchmark.start ();
;rep h;
;Benchmark.stopAndPrint "foldc";
