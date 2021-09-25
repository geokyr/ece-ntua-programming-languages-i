fun enum low high =
  if low <= high then
    low :: enum (low + 1) high
  else
    []

fun enum2 low high =
  let
    fun aux low high acc =
      if low <= high then 
        aux (low + 1) high (low :: acc)
      else
        acc (* rev acc *)
  in
    rev (aux low high []) (* aux low high [] *)
  end

fun enum3 low high l =
  if low <= high then
    enum (low + 1) high low :: l
  else
    rev l

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

fun bidlist2 [] = []
  | bidlist2 l =
      let
        fun walk [] next acc = rev acc
          | walk ((k, v) :: rest) next acc =
              if k = next then
                walk rest (next + 1) (v :: acc)
              else if k = next - 1 then
                walk rest next ((v + hd acc) :: tl acc)
              else
                walk ((k, v) :: rest) (next + 1) (0 :: acc)
        fun keycomp ((f1, s1), (f2, s2)) = f1 > f2
      in
        walk (ListMergeSort.sort keycomp l) 0 []
      end