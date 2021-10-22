fun split n L =
    let 
        fun aux 0 acc L = (rev acc, L)
          | aux n acc [] = (rev acc, [])
          | aux n acc (h :: t) = aux (n - 1) (h :: acc) t
    in 
        aux n [] L
    end

fun pick_in_order l =
    let
        fun constructor (h :: t) 0 acc =
                if (hd h) then constructor t 0 ((hd h)::acc)
                else constructor t 0 acc
          | constructor (h :: t) n acc =
                constructor ((tl h) :: t) (n - 1) acc
          | constructor [] n acc = 
                rev acc
        fun aux l n [] =
            constructor ...
    in
        constructor l 0 []
    end