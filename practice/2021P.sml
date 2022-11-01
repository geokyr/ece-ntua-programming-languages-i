fun reduceB f g [] = g
  | reduceB f g (h::t) = 
    f(h, reduceB f g t)

fun len [] = 0
  | len l =
    reduceB (fn(a, sum) => sum + 1) 0 l

fun suffixes [] = [[]]
  | suffixes l =
      let
        fun aux (h, tailh::tailt) =
          (h::tailh)::(tailh::tailt)
      in
        reduceB aux [[]] l
      end

val y = ref 1;

fun f x = 
  (!y) + (x + x);

(f (y := (!y) + 1; !y)) + (!y);

(* ----------------------- *)

(* 2a *)
fun reduceB g F [a] = F (a, g)
  | reduceB g F (a::t) = F(a, reduceB g F t);

(* 2b *)
fun count (_, c) = c + 1;
fun len a = reduceB 0 count a;

(* 2c *)
fun tail (a, []) = [a] :: [[]]
  | tail (a, res) = (a :: (hd res)) :: res;
fun suffixes a = reduceB [] tail a;
