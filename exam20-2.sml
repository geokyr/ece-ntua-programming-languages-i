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
        acc
  in
    rev (aux low high [])
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

(* ----------------------- *)

(* 2a *)
fun enum low high =
  let
    fun tr prev n low =
      if (n = low) then prev
      else tr ((n-1) :: prev) (n-1) low;
  in
    tr [] (high+1) low
  end

(* 4 *)
fun mergeSort nil = nil
  | mergeSort [a] = [a]
  | mergeSort theList =
    let
      fun halve nil = (nil, nil)
        | halve [a] = ([a], nil)
        | halve (a::b::cs) =
          let
            val (x, y) = halve cs
          in
            (a::x, b::y)
          end
      fun merge (nil, b) = b
        | merge (a, nil) = a
        | merge ((indexa, a)::at, (indexb, b)::bt) =
          if indexa < indexb then (indexa, a) :: merge (at, ((indexb, b)::bt))
                   else (indexb, b) :: merge (((indexa, a)::at), bt)

      val (x, y) = halve theList
    in
      merge (mergeSort x, mergeSort y)
    end

fun sum [] _ prev = ([], prev)
  | sum a n prev =
    let
      val (i, p) = hd a
    in
      if (i = n) then sum (tl a) n (prev + p)
      else (a, prev)
    end

fun loop [] i = []
  | loop a i =
    let
      val (newa, s) = sum a i 0
    in
      s :: (loop newa (i+1))
    end

fun bidlist L =
  let
    val newL = mergeSort L
  in
    loop newL 0
  end