round(File, MinDistance, MinIndex):-
    read_input(File, Towns, Cars, CarPositions),
    main(MinDistance, MinIndex, Towns, Cars, CarPositions).

read_input(File, M, N, C):-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, C).

read_line(Stream, L):-
    read_line_to_codes(Stream , Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

main(Answer, Index, Towns, Cars, List):-
    calculateMaxAndSum(List, Towns, 0, Max, Sum, StartMax, StartSum, StartTown),
    msort(List, SortedList),
    townsArray(Towns, SortedList, TownsArr),
    nextPos(TownsArr, 0, NextPos),
    solve(Towns, Cars, List, TownsArr, Max, Sum, Towns * Cars, 0, 0, NextPos).

isValid(Max, Sum, Flag):-
    Max <= (Sum - Max) + 1 -> Flag = 1
    ;
    Flag = 0.
    
calculateMaxAndSum([], T, Current, Max, Sum, Max, Sum, Current).

calculateMaxAndSum([H|Ts], T, Current, Max, Sum, StartMax, StartSum, StartTown):-
    calculateDistance(H, T, Current, Distance),
    NewMax is max(Max, Distance),
    NewSum is Sum + Distance,
    calculateMaxAndSum(Ts, T, Current, NewMax, NewSum, StartMax, StartSum, StartTown).

calculateDistance(H, T, Current, Distance):-
    (
    Current >= H -> Distance is Current - H
    ;
    Distance is T + Current - H
    ).

nextPos(TownArr, Second, NextPos):-

solve(T, C, L, TownArr, Max, Sum, Answer, Index, First, Second):-

findDistance(...):-

townsArray(Towns, [H|T], [1]).

townsArray(5, 0|[2,2,2], [])
    townsArray(5, 2|[2,2], [])
    townsArray(5, 2|[2], [])
    townsArray(5, 2, [])

townsArray(Towns, [H1,H2|T], NewList):-
    townsArray(Towns, [H2|T], [NH|NT]),
    H1 =:= H2 -> Temp is NH + 1,
    NewList = [Temp|NT]
    ;
    H1 =:= H2 - 1 -> append([1], [NH|NT], NewList)
    ;
    

findNewSum(Sum, C, T, TownArr, NewSum):-