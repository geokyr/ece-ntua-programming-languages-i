kap(NewList):-
    append([1], [2, 3, 4], [H|T]),
    Temp is H + 1,
    NewList = [Temp|T].