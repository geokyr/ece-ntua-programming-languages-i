unique([]).
unique([Item | Rest]) :-
    member(Item, Rest), !, fail.
unique([_ | Rest]) :-
    unique(Rest).

% ---------------------------

unoddsum(n(T1,T2,T3), T) :- unoddsum(T1, X1), unoddsum(T2, X2), unoddsum(T3, X3),  add(S, X1, X2, X3), candr(S, T, X1, X2, X3).
unoddsum(T, T).


add(D , X1, X2, X3) :- integer(X1), integer(X2), integer(X3), D is X1 + X2 + X3.
add(n(X1,X2,X3) ,X1,X2,X3).

candr(S, 17,  X1, X2, X3) :- integer(S), F is S mod 2, F = 1.
candr( _, n(X1,X2,X3),  X1, X2, X3).


unique([]).
unique([Item | Rest]) :-
not(member(Item, Rest)), unique(Rest).

% ---------------------------

maximize(T, MaxTree) :- find_max(T, X), replace(T, X, MaxTree).

replace(n(T1,T2,T3),N,n(F1,F2,F3)) :-  replace(T1,N,F1), replace(T2,N,F2), replace(T3,N,F3).
replace(T,N,N).

find_max(n(T1,T2,T3),X) :- find_max(T1, Y), find_max(T2, W), find_max(T3, Z),  L is max(Y, W), X is max(Z, L).
find_max(T,T).

% ---------------------------

5)
α)
maximize(Tree, MaxTree):-
    get_max(Tree, 0, Max),
    transform(Tree, Max, MaxTree).

get_max(N, CurrMax, Max):-
    integer(N),
    Max is max(N, CurrMax).
get_max(n(T1,T2,T3), CurrMax, Max):-
    get_max(Τ1, CurrMax, Max1),
    get_max(Τ2, Max1, Max2),
    get_max(Τ3, Max2, Max).

transform(N, Max, Max):-
    integer(N).
transform(n(T1,T2,T3), Max, n(T4,T5,T6)):-
    transform(T1, Max, T4),
    transform(T2, Max, T5),
    transform(T3, Max, T6).

β)
unoddsum(N, N):-
    integer(N).
unoddsum(n(T1,T2,T3), Term):-
    unoddsum(T1, Term1),
    unoddsum(T2, Term2),
    unoddsum(T3, Term3),
    ((integer(Term1),        % maplist(integer, [Term1,Term2,Term3])
     integer(Term2),
     integer(Term3),
     S is Term1 + Term2 + Term3,
     1 is S mod 2) -> Term = 17
    ;
     Term = n(Term1, Term2, Term3)
    ).