(* 1 *)

fun s ls =
  let
    fun c [] a = a
      | c (x :: r) a = c r ((x :: r) :: a)
  in c ls []
end

fun find [] prev max = ([], max)
  | find a prev max =
    if ((hd a) mod 2 = prev) then (a, max)
    else find (tl a) (1-prev) (max + 1);

fun loop [] max = max
  | loop a max =
    let
      val (newa, r) = find (tl a) ((hd a) mod 2) 1
    in
      if (r > max) then loop newa r
      else loop newa max
    end

fun oddeven L = loop L 0

(* 2 *)

fun c ls =
  let
    fun d [] n a = a
      | d (42 :: t) n a = d t (n + 1) (Int.max(n + 1, a))
      | d (h :: t) n a = d t 0 a
  in
    d ls 0 0
  end

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

(* 3 *)

fun check k n =
  k * k > n orelse
  n mod k <> 0 andalso
  check (k + 2) n

fun prime 2 = true
  | prime n = n mod 2 <> 0 andalso check 3 n

fun reverse xs =
  let
    fun rev (nil, z) = z
      | rev (y::ys, z) = rev (ys, y::z)
  in
    rev (xs, nil)
  end

fun find a 0 prev = (reverse prev, a)
  | find a N prev = find (tl a) (N-1) ((hd a) :: prev);

fun reconstruct [] = []
  | reconstruct L =
  let
    val h = hd L
    val (new, rest) = find (tl L) h []
  in
    (h :: new) :: (reconstruct rest)
  end