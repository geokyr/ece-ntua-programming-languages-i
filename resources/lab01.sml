fun halve [] = ([], [])
  | halve [x] = ([x], [])
  | halve (x :: y :: rest) =
      let
        val (left, right) = halve rest
      in
        (x :: left, y :: right)
      end

fun splitAt k [] = ([], [])
  | splitAt 0 l = ([], l)
  | splitAt k (h :: t) =
      let
        val (left, right) = splitAt (k-1) t
      in
        (h :: left, right)
      end

fun split l =
  let
    val n = length l
  in
    splitAt ((n+1) div 2) l
  end

fun assert msg cond =
  if not cond then print ("wrong! " ^ msg ^ "\n") else ()

fun test_split f = (
  assert "[]" (f [] = ([], []));
  assert "one element" (f [42] = ([42], []));
  assert "two elements" (f [17, 42] = ([17], [42]));
  assert "three elements" (f [1, 2, 3] = ([1, 2], [3]));
  assert "four elements" (f [1, 2, 3, 4] = ([1, 2], [3, 4]));
  assert "five elements" (f [1, 2, 3, 4, 5] = ([1, 2, 3], [4, 5]))
)
