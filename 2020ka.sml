(* fun s ls =
  let
    fun c [] a = a
      | c (x :: r) a = c x (r :: a)
  in 
    c ls []
  end *)

fun s2 ls =
  let 
    fun c [] a = a
      | c (x :: r) a = c r ((x :: r) :: a)
  in 
    c ls []
  end