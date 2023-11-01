fun enum low high =
  let
    fun aux low high acc =
      if low <= high then 
        aux (low + 1) high (low :: acc)
      else
        acc
  in
    rev (aux low high [])
  end

fun bidlist [] = []
  | bidlist ((k, v) :: rest) =
      let
        fun insert 0 v [] = [v]
          | insert k v [] = 0 :: insert (k - 1) v []
          | insert 0 v (x :: r) = (x + v) :: r
          | insert k v (x :: r) = x :: insert (k - 1) v r
      in
        insert k v (bidlist rest)
      end