bagger :-
	reset,
	o([new,items is [bread, 
	             glop, granola,
                     granola,iceCream,
                     potatoChips],commit],_,_),

	X is cputime,
        listing(order),nl,
	once(do(check_order)),
	Y is cputime,
	Runtime is Y - X,
	listing(order),
	listing(bag),
	format('\nRUNTIME: ~w ms',[Runtime]).

reset :-
	forall(touch(_,resets,_),true),
	retractall(alreadyUsed(_,_,_,_,_)).

do(Group) :-
	spy('entering ~w\n',[Group]),
	orderings(Group,Orders),
	member(Order,Orders),
        clause(if(Group,Label,Order,Id,Wme,Vars),_),
        print(checking(Id)),nl,%(Id = b3 -> spy(if) ; true),
        if(Group,Label,Order,Id,Wme,Vars),
        %print(yup(Id)),nl,
	\+ alreadyUsed(Group,Label,Id,Wme,Vars),
	assert(alreadyUsed(Group,Label,Id,Wme,Vars)),	
	spy('!~w ~w (~w)',[Group,Id,Label]),
        print(firing(Id)),
        (thens(Group,Label,Id,Wme,Vars) 
          -> listing(bag),
             listing(order),
             get0(_)
          ;  print(failed(Group,Id)),fail),
        spy(';; \n',[]),
	do(Group).
do(_).	

thens(Group,Label,Id,Wme,Vars) :-
  then(Group,Label,Id,Wme,Vars),!.
thens(Group,Label,Id,_,_) :-
  print(failedRuleAction(Group,Label,Id)),nl,fail.

spy(_,_) :- shutUp,!.
spy(X,Y) :- format(X,Y).

quiet :- shutUp,!.
quiet :- assert(shutUp).

loud :- retract(shutUp),!.
loud.
