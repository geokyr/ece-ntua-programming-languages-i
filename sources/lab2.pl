%%===========================================================================
%% Solution to the Man-Wolf-Goat-Cabbage Puzzle
%%===========================================================================

/* config(Man, Wolf, Goat, Cabbage) */
initial(config(w, w, w, w)).
final(config(e, e, e, e)).

opposite(w, e).
opposite(e, w).

/* move(Conf1, Move, Conf2) */
move(config(Coast, Coast, G, C), wolf, config(OppCoast, OppCoast, G, C)) :-
    opposite(Coast, OppCoast).
move(config(Coast, W, Coast, C), goat, config(OppCoast, W, OppCoast, C)) :-
    opposite(Coast, OppCoast).
move(config(Coast, W, G, Coast), cabbage, config(OppCoast, W, G, OppCoast)) :-
    opposite(Coast, OppCoast).
move(config(Coast, W, G, C), nothing, config(OppCoast, W, G, C)) :-
    opposite(Coast, OppCoast).

together_or_separated(Coast, Coast, Coast).  % together
together_or_separated(_, Coast1, Coast2) :- opposite(Coast1, Coast2).

safe(config(Man, Wolf, Goat, Cabbage)) :-
    together_or_separated(Man, Wolf, Goat),
    together_or_separated(Man, Goat, Cabbage).

/* solve(+Conf, ?Moves) */
solve(Conf, []) :- final(Conf).
solve(Conf, [Move|Moves]) :-
    move(Conf, Move, Conf1),
    safe(Conf1),
    solve(Conf1, Moves).

/* solve(-Moves) */
solve(Moves) :-
    initial(InitialConf),
    length(Moves, _),
    solve(InitialConf, Moves).


%%===========================================================================
%% Solution to the Eight Queens problem
%%===========================================================================

/* nocheck(+Queens, +Queen) */
nocheck([], _).
nocheck([X1/Y1 | Rest], X/Y) :-
    %% X =\= X1,
    Y =\= Y1,
    abs(Y1-Y) =\= abs(X1-X),
    nocheck(Rest, X/Y).

legal([]).
legal([X/Y | Rest]) :-
    legal(Rest),  % generate a Rest list
    %% member(X, [1,2,3,4,5,6,7,8]),
    member(Y, [1,2,3,4,5,6,7,8]),
    nocheck(Rest, X/Y).

eightqueens(Queens) :-
    Queens = [1/_, 2/_, 3/_, 4/_, 5/_, 6/_, 7/_, 8/_],
    legal(Queens).
