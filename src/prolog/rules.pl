:- dynamic (*)/1.

:- op( 999, xfy, meta).
:- op( 998, xfx,   if).
:- op( 997, xfx, then).
:- op( 996, xfy,   or).
:- op( 995, xfx,  and).
:- op( 994,  fy,  not).
:- op( 993,  fx,  (*)).
:- op( 703, xfx,   of).
:- op( 702, xfx,  now).
:- op( 100, xfx,   in).
:- op(   2,  fx, rule).
:- op(   1, xfx,  for).

%%%%%%%
% rule pre-processor
% for each rule, add a term holding the vars in the rule.

% Prolog's macro operator
% If it see X then term_expansion(X,Y) actually asserts Y
term_expansion(
      rule Rule for Task if If then Then, 
      rule(Specificity, Rule, Task, If, Then, 
           done(Rule,Task,V))) :-
  term_variables(( Rule,Task,If ), V1),
  term_variables(Then, V2),
  shares(V1, V2, V),
  prims(If, Specificity).

% returns variables shared by two lists
shares([], _, []).
shares([H | T1], L, [H | T2]) :- shares1(L, H), !, shares(T1, L, T2).
shares([_ | T1], L,      T2 ) :- shares(T1, L, T2 ).

shares1([H|_],X) :- H == X. 
shares1([_|T],X) :- shares1(T,X).

% count primitives

prims(X,N) :- prims1(X,N0), N is N0.

prims1(A and B,M+N) :-  !,prims1(A,M), prims1(B,N).
prims1(A or  B,M+N) :-  !,prims1(A,M), prims1(B,N).
prims1(not A,  N)   :-    prims1(A,N).
prims1(_,1).

%%%%%%%
% facts
* order of tasks = [init, elaborate, report].
* age of tim  =  20.
* age of john = 300.
* age of jane =   5.

%%%%%
% rules

rule 1      
for  init 
if   Who in [tim, john] and
     age of Who > 10
then job of Who now working.

rule 2 
for  init
if   age of Who > 100 
then status of Who now dead. 

%%%%%
% details
X and Y      :- X, Y.
X or _       :- X.
_ or Y       :- Y.
X in Y       :- member(X,Y).
X of Y =   Z :- * X of Y = Z.
X of Y >=  Z :- * X of Y = Z0, Z0 >= Z.
X of Y =<  Z :- * X of Y = Z0, Z0 =< Z.
X of Y \=  Z :- * X of Y = Z0, Z0 \= Z.
X of Y <   Z :- * X of Y = Z0, Z0 <  Z.
X of Y >   Z :- * X of Y = Z0, Z0 >  Z.
X of Y now Z :-
  retract(* X of Y = _) -> assert(* X of Y = Z);  assert(* X of Y = Z).

%%%%%%
% inference

thinks :- 
	retractall(done(_,_,_)), 
	* order of tasks = Tasks,
	maplist(think, Tasks),
	listing(*).

think(Task) :-
  	setof( Rule , match(Task,Rule), Rules), !,
  	selects(Rules, Then, Done),
  	asserta( Done ),
  	Then,
  	think(Task).
think(_).

match(Task, rule(Spec, Rule, Task, If, Then, Done)) :-
            rule(Spec, Rule, Task, If, Then, Done),
            If,
            not( Done ).

selects([ rule(_Spec, _Rule, _Task, _If, Then, Done) | _ ], Then, Done).

:- thinks, halt.
