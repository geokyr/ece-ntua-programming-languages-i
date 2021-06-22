datatype 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

fun floor t k =
	let
		fun walk Leaf sofar = sofar
			| walk (Node (x, l, r)) sofar =
					if k = x then SOME x
					else if k < x then walk l sofar
					else walk r (SOME x)
	in
		walk t NONE
	end

fun powerset [] = [[]]
	| powerset (h :: t) =
			foldl (fn (x, acc) => x :: (h :: x) :: acc) [] (powerset t)

fun allsubseq xs =
	let
		fun nonempty [] = []
			| nonempty (x :: xs) =
				let
					fun walk [] acc = rev acc
						| walk (ys :: yss) acc = 
								walk yss ((x :: ys) :: ys :: acc)
				in
					walk (nonempty xs) [[x]]
				end
	in
		[] :: nonempty xs
	end