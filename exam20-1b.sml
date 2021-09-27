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

(* ----------------------- *)

(* 2 *)
fun c ls =
  let
    fun d [] n prev = Int.max(n, prev)
      | d (42 :: t) n prev = d t (n + 1) prev
      | d (h :: t) n prev = d t 0 (Int.max(n, prev))
  in
    d ls 0 0
end

(* 4 *)
fun reverse xs =
  let
    fun rev (nil, z) = z
      | rev (y::ys, z) = rev (ys, y::z)
  in
    rev (xs, nil)
  end

fun even [] prev = reverse prev
  | even (h::t) prev =
    if ((h mod 2) = 0) then even t (h::prev)
    else even t prev

fun search a [] = []
  | search a ev =
    if ((hd ev) = 2*a) then ev
    else search a (tl ev)

fun loop [] _ ans = reverse ans
  | loop (h::t) ev ans =
    let
      val ret = search h ev
    in
      if (ret = []) then loop t ev ans
      else loop t (tl ret) ((h, 2*h)::ans)
    end

fun double_pairs L =
  let
    val evenarr = even L []
  in
    loop L evenarr []
  end
