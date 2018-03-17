
[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______

Logic Programming
=================

Prolog is the Fortran of logic programming: it was the first of its
kind, it was much criticised, and it is still widely used.

George Santayana: "Those who do not remember the past are condemned to
repeat it."

Tim Menzies: "Those who do not study Prolog are condemned to repeat it."

PROLOG came from natural langauge research in the 1970s, 1980s and was
an attempt to treat human texts as logic formulae. Hence, before we can
explain NL in PROLOG, we must explain PROLOG.

## Tree Matching == Unification

Prolog Terms = (Tree) Structured Data

```
type term
  = Constant of int
  | Atom     of string
  | Variable of string
  | Compound of string * term list
```

Atom = lowercase, variable = uppercase.

Equality is unification.
Two terms can be unified if we can substitute values for variables to make the terms identical

    
    ?- kim = kim.
    true.
    
    ?- kim = holly.
    false.
    
Unification is  recursive
    
    ?- foo(kim) = foo(kim).
    true.
    
    ?- foo(kim) = foo(holly).
    false.
    
    
Q: When is the term X identical to the term kim?    
A: When we substitute X with the value kim!
    
    ?- foo(X) = foo(kim).
    X = kim.
    
    ?- foo(X, dog) = foo(cat, Y).
    X = cat, Y = dog.
    
    ?- p(X, dog, X) = p(cat, Y, Y).
    
The top nodes of both trees have same predicate so go inside.
    
![](../img/tree1.png)
    
    ?- p(X, dog, X) = p(cat, Y, Y).
    
![](../img/tree2.png)
    
    ?- p(X, dog, X) = p(cat, Y, Y).
    
![](../img/tree4.png)

    ?- a(W, foo(W, Y), Y) = a(2, foo(X, 3), Z), print(y(Y)).
    y(3)
    W = X, X = 2,
    Y = Z, Z = 3.
    
Prolog programs are lots of tree fragments. At runtime,
one tree can hook into another. See below

Predicates, not Functions
-------------------------

Functions map inputs to outputs.

Predicates define constraints on variables.

Functions run.

Predictes match.

Functions return some output.

Predicates only return yes or no. If "yes", then as a side effect, they
may add bindings to variables.

Example: The Standard "Family" Database Example
-----------------------------------------------

(Adapted from Robert F. Rossa:
[rossa@csm.astate.edu](mailto:rossa@csm.astate.edu)).

### Prolog programs as databases

We show below a Prolog program consisting entirely of **simple clauses**
or facts. This set of facts is a database about a family.

    /* family.pl - a simple database for a family */
    gender(al,male).
    gender(anne,female).
    gender(arthur,male).
    gender(amber,female).
    gender(boris,male).
    gender(barbara,female).
    gender(betty,female).
    gender(buck,male).
    gender(carla,female).
    gender(charles,male).
    gender(cora,female).
    gender(cuthbert,male).
    gender(cecilia,female).
    gender(calvin,male).

    father(arthur,buck).
    father(al,buck).
    father(amber,buck).
    father(anne,boris).
    father(barbara,charles).
    father(betty,cuthbert).
    father(boris,charles).
    father(buck,calvin).

    mother(al,barbara).
    mother(anne,betty).
    mother(arthur,barbara).
    mother(amber,barbara).
    mother(boris,carla).
    mother(barbara,carla).
    mother(betty,cora).
    mother(buck,cecilia).

We can load this database into a Prolog interpreter.

    swipl -f family.pl
    ?-

Now the interpreter is waiting for us to query it. Every query must end
with a period. When we query the interpreter, it will give us the first
answer it finds, based on the facts in the database. If we want more
answers, we enter a semicolon. If we don't want any more answers to that
query, we just enter a carriage return. Thus consider the sequence that
follows.

    ?- father(X,Y).
    X=arthur,
    Y=buck;

    X=al,
    Y=buck;

    X=amber,
    Y=buck;

    X=anne,
    Y=boris;

    X=barbara,
    Y=charles;

    X=betty,
    Y=cuthbert;

    X=boris,
    Y=charles;

    X=buck,
    Y=calvin

    no
    ?-

So the *Father* successed many times, and as a side-effect, printed some
bindings. Then it automatically backtracked (on the ";" command) to find
other bindings.

In this example, PROLOG answers "no" since no data satisfies the
following constraints.

    ?- mother(al,betty).
    no
    ?- mother(al,barbara).
    yes
    ?- 

We can build more complex queries like the following, to find a
grandmother of al.

    ?- mother(al,X),mother(X,Y).
    X=barbara,
    Y=carla

    yes
    ?-

Which is to say that we are looking for a pattern and where "X" and "Y"
satisfy some constraints.

BTW, identifiers that start with an upper case letter are variables, and
those that start with lower case letters are constants.

### Rules

We can add some intelligence to our facts by adding a clause that tells
how to figure out from the simple clauses whether Y is a parent of X.
The **rules** we add are

    parent(X,Y) :- father(X,Y).
    parent(X,Y) :- mother(X,Y).

The symbol ':-' should be read as "if". Now we can query as follows.

    ?- parent(al,Y).
    Y=buck;

    Y=barbara

    yes
    ?-

We can now build a rule that uses the parent rules.

    grandfather(X,Y) :- parent(X,Z),father(Z,Y).

and ask questions like

    ?- grandfather(anne,Y).
    Y=charles;

    Y=cuthbert;

    no
    ?- 

Note that PROLOG has no pre-defined input output variables- everything
is a constraint. So we could have equally posed the above query as:

    ?- grandfather(X,anne).
    X=anne;

    no
    ?- 

The scope of variables is one clause; there is no such thing as a global
variable.

### Backtracking

When Prolog tries to answer a query, it goes through a matching process.
It tries to match the predicates on the right-hand side of the rule from
left to right, binding variables when it finds a match. If a match
fails, it may be because of the bondings in matches to the left. In that
case, the interpreter backtracks - it returns to the nearest previous
binding and tries to find a different match. If that fails, it
backtracks some more.

We can make Prolog print out all the answers to a question by
deliberately making it fail, using the fail predicate.

    ?- grandfather(X,Y),write('X='),write(X),write(', Y='),write(Y),nl,fail.
    X=arthur, Y=calvin
    X=al, Y=calvin
    X=amber, Y=calvin
    X=anne, Y=charles
    X=al, Y=charles
    X=anne, Y=cuthbert
    X=arthur, Y=charles
    X=amber, Y=charles
    no
    ?- 

Lists and Partial Structures
----------------------------

Prolog lists have heads and tails (think "car" and "cdr").

    member(A, [A|_]).
    member(A, [_|B]) :-
            member(A, B).

So, of course,...

    ?- member(a,[c,b,a]).
    true

But Prolog can bactrack to find all repeated members of a list:

    ?-    member(a,[c,a,b,a]).
    true ;
    true 

Also, we can find all members of a list:

    ?- member(X,[a,b,c]).
    X = a;
    X = b;
    X = c

Also, Prolog is a relational language. Variables are not inputs and
outputs but concepts woven together by constraints. Also, we only need
to partially specify the I/O to query those constraints:

    ?-  member(name=What, [age=20,shoesize=12,name=tim]).
    What = tim .

(If this is causing stress, just chant to yourself: in Prolog, we don't
code; rather, we draw the shape of the solution.)

This can get really funky. Here's the standard definition of how to
append two lists:

    append([], A, A).
    append([A|B], C, [A|D]) :-
            append(B, C, D).

Which works in the expected way:

    ?- append([a,b,c],[d,e,f],Out).
    Out = [a, b, c, d, e, f].

But *any* of these arguments can be left unspecified to achieve neat
results:

    ; find the third thing in a list
    ?- append([ _, _, Third], _, [alice,john,mike,tim,veronica,wendy]).
    Third = mike

    ; find the list before "tim"
    ?- append(Before, [tim | _], [alice,john,mike,tim,veronica,wendy]).
    Before = [alice, john, mike]

    ; find the list after "tim"
    ?- append(_, [tim | After], [alice,john,mike,tim,veronica,wendy]).
    After = [veronica, wendy]

You can even write "member" using "append":

    member1(X,L) :- append(_,[X|_],L).

    ?- member1(a,[b,c,a]).
    true .

    ?- member1(X,[b,c,a]).
    X = b ;
    X = c ;
    X = a ;
    fail.

Now with great power comes great responsbility. If you ask *find all
lists which can contain 'a'*, you can get an infinite set (of course).

    ?- member(a,L).
    L = [ a |_G246] ;
    L = [_G245,  a |_G249] ;
    L = [_G245, _G248,  a |_G252] ;
    L = [_G245, _G248, _G251,  a |_G255] ;
    L = [_G245, _G248, _G251, _G254,  a |_G258] ;
    L = [_G245, _G248, _G251, _G254, _G257,  a |_G261] ;
    L = [_G245, _G248, _G251, _G254, _G257, _G260,  a |_G264] ;
    L = [_G245, _G248, _G251, _G254, _G257, _G260, _G263,  a |_G267] ;

Lesson: logic, like anything else, must be used wisely.

Monkeys and Bananas
-------------------

(Written by yours truly.)

Prolog variables support generalizations. For example, the following
monkeys and bananas solution supports climbing onto a box anywhere in
the room as well as push anything to anywhere.

It uses the following database:

    % making Move in State1 results in State2;
    % move( State1, Move, State2)

    % representing the current state
    % state( MonkeyHorizontal, MonkeyVertical, BoxPosition, HasBanana)

Our goal is to get the banana.

    goal(state(_,_,_,has)).

Our start state...

    start(state(atfloor,onfloor,atwindow,hasnot)).

This is how we can get from state1 to state2:

    canget( S,[]) :- goal(S).             % base case
    canget( State1,[Act|Rest])  :-        % general case
      move( State1, Act, State2),         % Do something
      canget( State2,Rest).               % Repeat

The knowledge base:

    move( state( middle, onbox, middle, hasnot),   % Before move
          grasp,                                   % Grasp banana
          state( middle, onbox, middle, has) ).    % After move
    move( state( P, onfloor, P, H),
          climb,                                   % Climb box
          state( P, onbox, P, H) ). 
    move( state( P1, onfloor, P1, H),
          push( P1, P2),                           % Push box from P1 to P2
          state( P2, onfloor, P2, H) ).
    move( state( P1, onfloor, B, H),
          walk( P1, P2),                           % Walk from P1 to P2
          state( P2, onfloor, B, H) ).

Main program:

    main :- start(S0), canget(S0,  Steps),
            forall(member(Step,Steps), (print(Step),nl)).

Output:

    ?- main.
    walk(atfloor, atwindow)
    push(atwindow, middle)
    climb
    grasp
    true ;

We pause here (even though we asked PROLOG to backtrack and find more
solutions with the ";" command) to comment that we we got to the
bananas.

Moving on, as we backtrack, we see that the solution gets longer. This
is not a bug. What is going on?

    walk(atfloor, atwindow)
    push(atwindow, _G251)
    push(_G251, middle)
    climb
    grasp
    true ; % new solution found

    walk(atfloor, atwindow)
    push(atwindow, _G251)
    push(_G251, _G262)
    push(_G262, middle)
    climb
    grasp
    true ; % another solution found

    walk(atfloor, atwindow)
    push(atwindow, _G251)
    push(_G251, _G262)
    push(_G262, _G273)
    push(_G273, middle)
    climb
    grasp
    true . % yet another solution found

Hmm.... looks like we need to control how far the money walks.

Search control
--------------

(Adapted from [John
Fisher's](http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/3_3.html)
excellent Prolog tutorial.)

Prolog's hardwired search is depth-first through its list of clauses.
But this can easily be changed. For example, in this section we will
code up DFID in Prolog.

### Simple DFID

For our first DFID, we control the size of the list that shows the steps
taken to reach the goal. We can build that leash using the following
trick:

    ?-  between(1,5,N), length(List, N).
    N = 1,
    List = [_G292] ;
    N = 2,
    List = [_G292, _G295] ;
    N = 3,
    List = [_G292, _G295, _G298] ;
    N = 4,
    List = [_G292, _G295, _G298, _G301] ;
    N = 5,
    List = [_G292, _G295, _G298, _G301, _G304].

We will use this trick to define dfid as a loop around the monkey's
"canget" predicate:

    dfid(Max) :- 
        start(S0),
        between(1,Max,Depth), % on backtracking, Depth=1,2,3,...
        length(Steps,Depth),  % Steps is a list of size Depth
        print(leash(Steps)),nl,
        canget(S0,Steps),
        print(Depth),nl,
        forall(member(Step,Steps), (tab(4),print(Step),nl)).

For example:

    ?- dfid(5), fail. % backtrack through all solutions.
    leash([_G254])
    leash([_G254, _G257])
    leash([_G254, _G257, _G260])
    leash([_G254, _G257, _G260, _G263])

    4
        walk(atfloor, atwindow)
        push(atwindow, middle)
        climb
        grasp

    leash([_G254, _G257, _G260, _G263, _G266])

    5
        walk(atfloor, atwindow)
        push(atwindow, _G280)
        push(_G280, middle)
        climb
        grasp
    5
        walk(atfloor, atwindow)
        push(atwindow, middle)
        walk(middle, middle)
        climb
        grasp
    5
        walk(atfloor, _G272)
        walk(_G272, atwindow)
        push(atwindow, middle)
        climb
        grasp

