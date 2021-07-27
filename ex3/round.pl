round(File, M, C):-
    read_input(File, Towns, Cars, List),
    main(M, C, Towns, Cars, List)
    .

read_input(File, M, N, C):-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, C)
    .

read_line(Stream, L):-
    read_line_to_codes(Stream , Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L)
    .

main(Answer, AnswerIndex, Towns, Cars, List):-
    calculateMaxAndSum(List, Towns, 0, 0, 0, StartMax, StartSum, StartTown),
    msort(List, SortedList),
    createTownsArray(SortedList, Towns, [TownsArrHead|TownsArrTail]),
    createNonZeroArray([TownsArrHead|TownsArrTail], IndexArr),
    nextIndexArr(IndexArr, 1, FirstIndexArr),
    once(solve(TownsArrTail, FirstIndexArr, IndexArr, 1, Towns, Cars, StartMax, StartSum, StartTown, StartSum, Answer, AnswerIndex))
    .

isValid(Max, Sum, Flag):-
    Max =< (Sum - Max) + 1 -> Flag = true
    ;
    Flag = false
    .
    
calculateMaxAndSum([], Towns, Current, Max, Sum, Max, Sum, Current).

calculateMaxAndSum([H|T], Towns, Current, Max, Sum, StartMax, StartSum, StartTown):-
    calculateDistance(H, Towns, Current, Distance),
    NewMax is max(Max, Distance),
    NewSum is (Sum + Distance),
    calculateMaxAndSum(T, Towns, Current, NewMax, NewSum, StartMax, StartSum, StartTown)
    .

calculateDistance(H, Towns, Current, Distance):-
    H =< Current -> Distance is Current - H
    ;
    Distance is Towns + Current - H
    .

createTownsArray([H|T], Towns, TownsArr):-
    once(townsArray([H|T], Towns, TownsArrZeros)),
    correctZeros(-1, H, TownsArrZeros, TownsArr)
    .

townsArray([H], Towns, [1|Tail]):- correctZeros(H, Towns, [], Tail).

townsArray([H1,H2|T], Towns, NewList):-
    townsArray([H2|T], Towns, [NH|NT]),
    (
    H1 = H2 -> Temp is NH + 1,
    NewList = [Temp|NT]
    ;
    correctZeros(H1, H2, [NH|NT], Corrected),
    NewList = [1|Corrected]
    )
    .

correctZeros(Current, Target, List, CorrectedList):-
    Current =:= Target - 1 -> CorrectedList = List
    ;
    Temp is Target - 1,
    correctZeros(Current, Temp, [0|List], CorrectedList)
    .

createIndexArr([], _, []).

createIndexArr([0|T], Index, List):-
    NewIndex is Index + 1,
    createIndexArr(T, NewIndex, List)
    . 

createIndexArr([H|T], Index, [(Index, H)|Tail]):- 
    NewIndex is Index + 1,
    createIndexArr(T, NewIndex, Tail)
    .
    
createNonZeroArray(TownsArr, IndexArr):-
    once(createIndexArr(TownsArr, 0, IndexArr))
    .

nextIndexArr([(I, H)|T], Index, NextIndexArr):-
    Index >= I ->  nextIndexArr(T, Index, NextIndexArr)
    ;
    NextIndexArr = [(I, H)|T]
    .

findNewSum(OldSum, Cars, Towns, Head, NewSum):-
    NewSum is OldSum + Cars - Towns*Head
    .

isOptimal(OldSum, NewSum, Flag):-
    OldSum > -1 -> (
        NewSum < OldSum -> Flag = true
        ;
        Flag = false
    )
    ;
    Flag = true
    .

solve([], _, BackupList, _, Towns, Cars, MaxDistance, CurrentSum, SumIndex, Sum, Sum, SumIndex).

solve([Head|Tail], [], BackupList, Index, Towns, Cars, MaxDistance, CurrentSum, SumIndex, Sum, Answer, AnswerIndex):-
    solve([Head|Tail], BackupList, BackupList, Index, Towns, Cars, MaxDistance, CurrentSum, SumIndex, Sum, Answer, AnswerIndex)
    .

solve([Head|Tail], [(I, H)|T], BackupList, Index, Towns, Cars, MaxDistance, CurrentSum, SumIndex, Sum, Answer, AnswerIndex):-
    Index = I -> solve([Head|Tail], T, BackupList, Index, Towns, Cars, MaxDistance, CurrentSum, SumIndex, Sum, Answer, AnswerIndex)
    ;
    NewIndex is Index + 1,
    calculateDistance(I, Towns, Index, NewDistance),
    findNewSum(CurrentSum, Cars, Towns, Head, NewSum),
    isValid(NewDistance, NewSum, Flag),
    (
        Flag = true -> isOptimal(Sum, NewSum, SecondFlag),
        (
            SecondFlag = true -> solve(Tail, [(I, H)|T], BackupList, NewIndex, Towns, Cars, NewDistance, NewSum, Index, NewSum, Answer, AnswerIndex)
            ;
            solve(Tail, [(I, H)|T], BackupList, NewIndex, Towns, Cars, MaxDistance, NewSum, SumIndex, Sum, Answer, AnswerIndex)
        )
    ;
    solve(Tail, [(I, H)|T], BackupList, NewIndex, Towns, Cars, MaxDistance, NewSum, SumIndex, Sum, Answer, AnswerIndex)
    )
    .