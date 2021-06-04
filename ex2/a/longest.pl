read_input(File, Days, Hospitals, List) :-
    open(Fle, read, Stream),
    read_line(Stream, [Days, Hospitals]),
    read_line(Stream, List).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

modify_list(List, N, L) :-
    append(L, 0),
    member(X, List),
    X is - X + N,
    append(L, X).

prefix_list([],Ys).
prefix_list([X|Xs],[X|Ys]) :- prefix_list(Xs,Ys).

solve(Days, Hospitals, List, Answer) :-
    modify_list(List, Hospitals, L),
    prefix_list(PrefixL, L)
    same_length(PrefixL, L).

longest(File, Answer) :-
    read_input(File, Days, Hospitals, List),
    once(solve(Days, Hospitals, List, Answer).