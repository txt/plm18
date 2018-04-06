
@rule(_ = id
     ,_ = author
     ,_ = if
     ,_ = then
     ,_ = vars
     ,_ = wme
     ).

@cond(X)            :- int(3,1,G), & @cond(X,G).
@cond(cond(X),1)    :- & @ boolean(X).
@cond(and(L1,L2),N) :- splitN(N,50,N1,N2), & @cond(L1,N1), & @cond(L2,N2). 
@cond(or(L1,L2),N)  :- splitN(N,50,N1,N2), & @cond(L1,N1), & @cond(L2,N2).

@globals(Step = step) :-
	@step(Step).

@step(S) :-  S = check_order ror
             S = bag_large_items ror
             S = bag_medium_items ror
             S = bag_small_items.

	







