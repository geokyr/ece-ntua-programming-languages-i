%%
%% The final version of factorial/2 we wrote (using if-then-else).
%%
fact(N, F) :-
    ( N > 0 -> N1 is N - 1, fact(N1, F1), F is F1 * N
    ; N =:= 0, F = 1
    ).


%%===========================================================================
%% Solution to the zebra puzzle (https://en.wikipedia.org/wiki/Zebra_Puzzle)
%%===========================================================================

/*
** The representation we use is a structured term of the form:
**   house(Nationality, Color, Pet, Drink, Smoke)
**/

zebra(Houses) :-
    Houses = [house(norwegian, _, _, _, _),
	      house(_, blue, _, _, _),
	      house(_, _, _, milk, _), _, _],
    member(house(englishman, red, _, _, _), Houses),
    member(house(spaniard, _, dog, _, _), Houses),
    member(house(_, green, _, coffee, _), Houses),
    member(house(ukranian, _, _, tea, _), Houses),
    rightof(house(_, ivory, _, _, _), house(_, green, _, _, _), Houses),
    member(house(_, _, snails, _, old_gold), Houses),
    member(house(_, yellow, _, _, cools), Houses),
    nextto(house(_, _, _, _, chesterfields), house(_, _, fox, _, _), Houses),
    nextto(house(_, _, _, _, cools), house(_, _, horse, _, _), Houses),
    member(house(_, _, _, orange_juice, lucky_strike), Houses),
    member(house(japanese, _, _, _, parliaments), Houses).

rightof(H1, H2, [H1,H2,_,_,_]).
rightof(H1, H2, [_,H1,H2,_,_]).
rightof(H1, H2, [_,_,H1,H2,_]).
rightof(H1, H2, [_,_,_,H1,H2]).

nextto(H1, H2, Houses) :- rightof(H1, H2, Houses).
nextto(H1, H2, Houses) :- rightof(H2, H1, Houses).

owner_zebra(Owner) :-
    zebra(Houses),
    member(house(Owner, _, zebra, _, _), Houses).


%%===========================================================================
%% Solution to questions from Exam of July 2020
%%===========================================================================

max_data(n(Data, List), Max) :-
    max_list(List, Data, Max).

max_list([], Max, Max).
max_list([n(D, L)|Nodes], Data, Max) :-
    CurrentM is max(D, Data),
    max_list(L, CurrentM, ML),
    max_list(Nodes, ML, Max).


find_depth(n(Data,_), Data, 1).
find_depth(n(_,List), Data, Depth) :-
    member(Elem, List),
    find_depth(Elem, Data, ElemDepth),
    Depth is ElemDepth + 1.

%%------------- Tests below --------------------------------

test_max(Max) :- tree(Tree), max_data(Tree, Max).

test_depth(Data, Depth) :- tree(Tree), find_depth(Tree, Data, Depth).

tree(n(8, [n(4, [n(6, [n(1, [])]), n(3, [n(2, [])])]),
           n(5, [n(4, []), n(1, [])]),
           n(9, [n(5, [n(0, []), n(4, [])]), n(7, [n(2, [])])])])).
tree(n(1,[n(2,[n(17,[]),n(42,[])]),n(4,[n(5,[])])])).
