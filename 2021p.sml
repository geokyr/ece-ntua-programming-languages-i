fun reduceB f g [] = g
  | reduceB f g (h::t) = 
    f(h, reduceB f g t)

fun len [] = 0
  | len l =
    reduceB (fn(a, sum) => sum + 1) 0 l

fun suffixes [] = [[]]
  | suffixes l =
      let
        fun aux (h, tailh::tailt) =
          (h::tailh)::(tailh::tailt)
      in
        reduceB aux [[]] l
      end