/* vim: set filetype=prolog  : */

sneak(F) :- load_files([F],[silent(true)]).

:- sneak(grammer1).

%---------------
prim(X) :- var(X) | atomic(X). % X =.. [_,B], atomic(B).

runiv(Term,L) :-
        Term =..L0,
        once(maplist(runiv1, L0, L)).

runiv1(H,H)  :- prim(H).
runiv1(H0,H) :- runiv(H0,H).

%---------------
rprint(L) :- rprint([],L).

rprint(Pre,X) :-
  prim(X) -> rprint1(Pre,X) | X=[A|B], rprint(Pre,A), maplist(rprint(['|   '|Pre]),B).

rprint1([_|Pres],X) :-
	forall(member(Pre,Pres), write(Pre)),
	print(X), nl.

%-----------------
:- multifile sentence/2.
:- multifile sentence/3.

eg1 :-
	sneak(grammer1),
	forall(sentence(X,[]), (print(X),nl)).

eg2 :-
	sneak(grammer3),
	forall(sentence(X,[]), (print(X),nl)).

eg3 :- 	
	sneak(grammer2),
        sentence(Struct,[the, pumpkin, scares, the, lecturer],[]),
	print(Struct),nl.
