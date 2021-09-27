fun prime 2 = true
  | prime n = 
      let 
        fun check k =
          k * k > n orelse
          n mod k <> 0 andalso
          check (k + 2)
      in 
        n mod 2 <> 0 andalso check 3
      end

fun check2 k n =
  k * k > n orelse
  n mod k <> 0 andalso
  check2 (k + 2) n

fun prime2 2 = true
  | prime2 n = n mod 2 <> 0 andalso check2 3 n

fun reconstruct [] = []
  | reconstruct (h :: t) =
    let
      fun sublists i subl acc [] = rev acc
        | sublists i subl acc (h :: t) = 
            if i = 0 then
              sublists h [h] ((rev subl) :: acc) t
            else
              sublists (i - 1) (h :: subl) acc t
    in
      sublists h [h] [] (t)
    end

fun reconstruct2 [] = []
  | reconstruct2 (h :: t) =
    let
      fun sublists i subl acc [] = rev acc
        | sublists i subl acc (h :: t) = 
            if i > 0 then
              sublists (i - 1) (h :: subl) acc t
            else if h > 0 then
              sublists h [h] ((rev subl) :: acc) t
            else
              sublists (hd t) [hd t] ([0] :: (rev subl) :: acc) (tl t)
    in
      sublists h [h] [] t
    end

(* ----------------------- *)

(* 4 *)
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