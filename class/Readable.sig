signature ReadableCore = sig
  type readable

  val scan : (char, readable, 'x) scanner
end

signature WritableCore = sig
  type writable

  val nacs : (char, writeable, 'x) rennacs
end
