fun common_prefix x y =
    let 
        fun aux (h1 :: t1) (h2 :: t2) prefix = 
            if h1 = h2 then aux t1 t2 (h1::prefix)
            else (rev prefix, (h1 :: t1), (h2 :: t2))
          | aux s1 s2 prefix = (rev prefix, s1, s2)
    in 
        aux x y []
    end

(* ----------------------- *)

datatype 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

fun parity Leaf s = s mod 2 (*So that parent never kicks leaf*)
|   parity (Node(x,l,r)) s = x mod 2

fun cutting (Leaf) = [Leaf]
|   cutting (Node(x,l,r)) =
    let 
        val par = x mod 2
        val parl = parity l x
        val parr = parity r x
        val l_head::list_l = cutting l (*returns list, head always includes current node*)
        val r_head::list_r = cutting r 
        val full_tail = list_l @ list_r (*Tails are disconnected either way so they will be in the final list*)
    in 
        (*Return either Node + Tail or Node + something cut + Tail*)
        if (parl = par) andalso parr = par then Node(x,l_head,r_head)::full_tail
        else if parl = par then Node(x,l,Leaf)::r_head::full_tail
        else if parr = par then Node(x,Leaf,r)::l_head::full_tail
        else Node(x,Leaf,Leaf)::r_head::l_head::full_tail
    end

(* ----------------------- *)

datatype 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

fun trim Leaf = [Leaf]
  | trim (Node (n, l, r)) =
    let
      fun parity (Node (x, l, r) :: tail) =
        if (n - x) mod 2 = 0
        then (Node (x, l, r), tail)
        else (Leaf, Node (x, l, r) :: tail)
        | parity _ = (Leaf, []) (* parity [Leaf] *)

      val (ltree, ltail) = parity (trim l)
      val (rtree, rtail) = parity (trim r)
    in
      [Node (n, ltree, rtree)] @ ltail @ rtail
    end

(*

trim (Node(42,
      Node(17, Node(6, Node(4, empty, empty), Node(10, empty, empty)), Node(9, empty, empty)),
      Node(8, Node(2, empty, empty), Node(4, Node(3, empty, empty), Node(6, empty, empty)))));

*)