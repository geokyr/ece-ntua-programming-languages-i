calcDistance(Source, Destination, CityCount, Distance) :- 
    (  
        Source =< Destination -> Distance is Destination - Source
        ; Distance is CityCount - Source + Destination
    ).


calcSumMax([], Sum, Max, City, CityCount, [Sum, Max, City]).  

calcSumMax([H|T], Sum, Max, City, CityCount, Result) :- 
    calcDistance(H, City, CityCount, Distance), 
    SumNew is (Sum + Distance), 
    MaxNew is max(Distance, Max), 
    calcSumMax(T, SumNew, MaxNew, City, CityCount, Result).