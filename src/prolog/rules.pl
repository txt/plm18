:- dynamic (*)/1.

:- op( 999, xfx, holds).
:- op( 998, xfx,   if).
:- op( 997, xfx, then).
:- op( 996, xfy,   or).
:- op( 995, xfx,  and).
:- op( 994,  fx,  (*)).
:- op( 703, xfx,   of).
:- op( 702, xfx,  now).
:- op( 100, xfx,   in).
:- op(   2,  fx, rule).
:- op(   1, xfx,  for).

%%%%%%%
% rule pre-processor
% for each rule, add a term holding the vars in the rule.

term_expansion(
      rule R for S if Y then Z, 
      rule R for S if Y then Z holds uses(R,S,V)) :-
  term_variables(rule R for S if Y, V1),
  term_variables(Z, V2),
  shares(V1, V2, V).

% returns variables shared by two lists
shares([], _, []).
shares([H | T1], L, [H | T2]) :- shares1(L, H), !, shares(T1, L, T2).
shares([_ | T1], L,      T2 ) :- shares(T1, L, T2 ).

shares1([H|_],X) :- H == X. 
shares1([_|T],X) :- shares1(T,X).

%%%%%%%
% facts
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

%%%%%%
% inference

thinks :- retractall(uses(_,_,_)), think, listing(*).

think :-
  bagof(Rule, match(Rule), Rules), !,
  selects(Rules, Act, Uses),
  asserta( Uses ),
  Act,
  think.
think.

match(X if Condition then Act holds Uses) :-
      X if Condition then Act holds Uses,
      Condition,
      not( Uses ).

selects([_ if _ then Act holds Uses | _ ], Act, Uses).

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

:- thinks, halt.
