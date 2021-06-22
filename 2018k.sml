datatype heap = empty | node of int * heap * heap

fun isHeap empty = true
  | isHeap (node(x, l, r)) =
      let
        fun aux x empty = true
          | aux x (node(y, l, r)) = 
              x <= y andalso aux y l andalso aux y r
      in
        aux x l andalso aux x r
      end

fun itermap f [] = []
  | itermap f (h :: t) =
    h :: itermap f (map f t)