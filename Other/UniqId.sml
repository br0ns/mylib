structure UniqId : UniqId =
struct
    val r = ref 0

    fun next _ = Int.toString (inc r)
end
