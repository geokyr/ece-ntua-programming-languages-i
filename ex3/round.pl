round(File, M, C):-
    read_input(File, Towns, Cars, CarPositions),
    main(M, C, Towns, Cars, CarPositions).

read_input(File, M, N, C):-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, C).

read_line(Stream, L):-
    read_line_to_codes(Stream , Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

main(A, I, T, C, L):-
    calculateMaxAndSum(L, T, 0, Max, Sum, StartMax, StartSum, StartTown),

    townArray(T, L, TownArr),
    nextPos(TownArr, 0, NextPos),
    solve(T, C, L, TownArr, Max, Sum, T * C, 0, 0, NextPos)

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

townArray(T, L, TownArr):-

findNewSum(Sum, C, T, TownArr, NewSum):-