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

(* fun reconstruct [] = []
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
    end *)

fun reconstruct [] = []
  | reconstruct (h :: t) =
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