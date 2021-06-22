fun c ls =
  let 
    fun d [] n = n
      | d (42 :: t) n = d t (n + 1)
      | d (h :: t) n = Int.max (n, d t 0)
  in
    d ls 0
  end

fun c2 ls =
  let
    fun d [] n a = a
      | d (42 :: t) n a = d t (n + 1) (Int.max(n + 1, a))
      | d (h :: t) n a = d t 0 a
  in
    d ls 0 0
  end

fun double_pairs [] = []
  | double_pairs (h :: t)  =
      let
        fun aux h [] l = rev l
          | aux h (head :: tail) l =
            if (head > (2 * h)) then 
              aux head??? tail l
            else (
              if (head = (2 * h)) then 
                aux head tail ((h, head) :: l)
              else
                aux h tail l
            )
      in
        aux h t []
      end