% /* vim: set filetype=prolog :*/

:- discontiguous slot/5.
:- index slot(1,1,0,0,0).

:- op(699,yfx,of).

o( A of B) -->  o(get(A,V)), { o(B,V) }.
o( A == N) -->  o(get(A,V)), {V == N}.
o( A \= N) -->  o(get(A,V)), {V \= N}.
o( A >= N) -->  o(get(A,V)), {V >= N}.
o( A >  N) -->  o(get(A,V)), {V >  N}.
o( A <  N) -->  o(get(A,V)), {V <  N}.
o( A =< N) -->  o(get(A,V)), {V =< N}.
o(get(Field,V)) --> o(set(Field,V,V)).
o(set(Field,V0,V),Term0,Term) :- 
	slot(Term0,Field,V0,V,Term).

xpand(Functor=L,Out) :-
	nth(Tmp,L,Pos),
	length(L,Arity),
	once(complete(Tmp,Field,_)),
	Out  =..  [slot,Term0,Field,V0,V,Term],
	functor(Term0,Functor,Arity),
	functor(Term, Functor,Arity),
	arg(Pos,Term0,V0),
	arg(Pos,Term, V).

xpand(Functor=L,isa(F,Blank,Default)) :-
	length(L,Arity),
	functor(Blank, Functor, Arity),
### let me add complete here
	
complete(Field=Value,Field,Value).
complete(Field,      Field,_).
	

term_expansion(X=L,E) :- bagof(Y,xpand(X=L,Y),L).

emp = [name=23,age=0,sex=m].
