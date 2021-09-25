unique([]).
unique([Item | Rest]) :-
    member(Item, Rest), !, fail.
unique([_ | Rest]) :-
    unique(Rest).