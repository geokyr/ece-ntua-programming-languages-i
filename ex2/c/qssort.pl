/* state(Queue, Stack, Moves) */
final(state(Queue, [], Moves)) :- isSorted(Queue).

isSorted( [] ) .
isSorted( [_] ) .
isSorted( [X,Y|Z] ) :- X =< Y , isSorted( [Y|Z] ) .

popQ([Head|Tail], Head, Tail).

popS([Top|Stack], Top, Stack).

count(_, [], 0).
count(X, [X | T], N) :-
  !, count(X, T, N1),
  N is N1 + 1.
count(X, [_ | T], N) :-
  count(X, T, N).

check(Letter, state(Q, S, Moves), Size) :-
    count(Letter, Moves, Occurences),
    NewSize is Size / 2,
    NewSize >= Occurences.

/* move(state1, Move, state2) */
move(state(Queue, Stack, Moves), q, state(NewQueue, NewStack, NewMoves)) :-
    popQ(Queue, Popped, NewQueue),
    append([Popped], Stack, NewStack),
    append(Moves, ['Q'], NewMoves). 

move(state(Queue, Stack, Moves), s, state(NewQueue, NewStack, NewMoves)) :-
    popS(Stack, Popped, NewStack),
    append(Queue, [Popped], NewQueue),
    append(Moves, ['S'], NewMoves). 

/* solve(+Conf, ?Moves) */
solve(State, [],  Size) :- final(State).
solve(State, [Move|Moves],  Size) :-              
    check('S', State, Size),
    check('Q', State, Size),
    move(State, Move, State1),   
    solve(State1, Moves, Size).

checkEven(Num) :-
    0 is mod(Num, 2).

len(List, Length) :-
    length(List, Length),
    checkEven(Length).

/* solve(-Moves) */
main(UpperCaseMoves, C) :-
    len(Moves, _),
    length(Moves, Size),
    solve(state(C, [], []), Moves, Size),
    atomics_to_string(Moves, MovesString),
    string_upper(MovesString, UpperCaseMoves).

qssort(File, Moves) :- 
    read_input(File, N, C),
    (isSorted(C) -> Moves = "empty" ; once(main(Moves, C))).

read_input(File, N, C) :-
    open(File, read, Stream),
    read_line(Stream, [N]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).