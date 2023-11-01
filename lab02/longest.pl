longest(File, Answer):-
    read_input(File, M, N, C),
    main(Answer, M, N, C).

read_input(File, M, N, C):-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, C).

read_line(Stream, L):-
    read_line_to_codes(Stream , Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

main(MaxDiff, Days, Hospitals, [H|T]):-
    modify([H|T], Hospitals, Modified),
    prefix(Modified, 0, 0, Temp, [Hp|Tp]),
    lmin([Hp|Tp], Lmin, Hp),
    reverse([Hp|Tp], [Hr|Tr]),
    rmax([Hr|Tr], RRmax, Hr),
    reverse(RRmax, Rmax),
    loop(Lmin, Rmax, 0, Days, 0, 0, MaxDiff2),
    MaxDiff is max(MaxDiff2, Temp).

modify([], _, []).
modify([H|T], N, [Hm|Tm]):-
    Hm is -N-H,
    modify(T, N, Tm).

prefix([], Index, Sum, Temp, []):-
    Sum >=0 -> Temp = Index 
    ;
    Temp = 0.
prefix([H|T], Index, Sum, Temp, [Hp|Tp]):-
    Hp is H + Sum,
    NewIndex is Index + 1,
    prefix(T, NewIndex, Hp, Temp, Tp).

lmin([], [], _).
lmin([H|T], [Hml|Tml], Min):-
    H < Min -> Hml is H, lmin(T, Tml, Hml)
    ;
    Hml is Min, lmin(T, Tml, Min).

rmax([], [], _).
rmax([H|T], [Hmr|Tmr], Max):-
    H > Max -> Hmr is H, rmax(T, Tmr, H)
    ;
    Hmr is Max, rmax(T, Tmr, Max).

loop(_, _, MaxDiff2, M, M, _, Y):-
    Y is MaxDiff2.
loop(_, _, MaxDiff2, M, _, M, Y):-
    Y is MaxDiff2.
loop([Hml|Tml], [Hmr|Tmr], MaxDiff2, M, I, J, Y):-
    Hml =< Hmr -> 
    (Temp is max(MaxDiff2, J-I),
    NewJ is J+1,
    loop([Hml|Tml], Tmr, Temp, M, I, NewJ, Y)
    )
    ;
    (NewI is I+1,
    loop(Tml, [Hmr|Tmr], MaxDiff2, M, NewI, J, Y)
    ).