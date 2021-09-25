fun enum low high =
    if low <= high then
        low :: enum (low+1) high
    else
        []

fun enum2 low high =
    let
        fun aux low high acc =
            if low <= high then
            aux (low+1) high (low::acc)
        else
            rev acc
    in
        aux low high []
    end