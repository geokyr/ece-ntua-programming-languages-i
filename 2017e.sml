fun sizeUnbalanced empty = (0, 0)
  | sizeUnbalanced (node (_, left, right)) =
      let
        val (sLeft, uLeft) = sizeUnbalanced left
        val (sRight, uRight) = sizeUnbalanced right
      in
      (
        sLeft + sRight + 1, (* number of nodes under this tree *)
        uLeft + uRight + (if sLeft = sRight then 0 else 1)
      )
      end

fun countUnbalanced T = #2 (sizeUnbalanced T)