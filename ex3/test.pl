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