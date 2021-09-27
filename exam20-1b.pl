triadiko_01(n(T1,T2,T3),Zeros,Ones) :- triadiko_01(T1,Z1,O1), triadiko_01(T2,Z2,O2), triadiko_01(T3,Z3,O3), append(Z1, Z2, Z4), append(Z4, Z3, Zeros), append(O1, O2, O4), append(O4, O3,Ones).
triadiko_01(0,[0],[]).
triadiko_01(1,[],[1]).


 count_odd_parity(n(T1,T2,T3),Count) :- check_leaf(T1,T2,T3, Count).
 count_odd_parity(n(T1,T2,T3),Count) :- count_odd_parity(T1,C1), count_odd_parity(T2,C2), count_odd_parity(T3,C3), Count is C1+C2+C3.
 count_odd_parity(_,0).
 
 
 check_leaf(T1,T2,T3, Count) :- integer(T1), integer(T2), integer(T3), F is T1 + T2 + T3, Count is F mod 2.
 
 