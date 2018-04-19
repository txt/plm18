[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Review

### Week 15-16 : 04/12/2018 ~ 04/17/2018

Q1. What is a fact in prolog? Can the term in a fact be a variable?

Q2. Which of the following is not a correct query?

	?- student(Lisa, 5). 
	?- student(Lisa, X), student(Abraham, X). 
	?- student(Abraham, X) 


Q3. Backtracking is basically a form of searching. Briefly describe how does prolog do backtracking?

Q4. Can a query be made up of more than one subgoal?

Q5. Which of the following is not a variable? What a legal variable should be like?

	a12
	_global
	_KEN
	_100_
	C_3
	COM
	28k
	plm_18
	
Q6. What is the meaning of free/bound variable?

Q7. In prolog, can you have structures within structures? Give an example if yes.


What does the following code do?

Q8a.

    testone([],[]).
    testone([_|A],[_|B]) :- testone(A,B).

Q8b.

    testtwo([]).
    testtwo([_]).
    testtwo([H,H|R]) :- testtwo([H|R]).	


When having the following fact:

	parent(pat,jim). 
	parent(pam,bob). 
	parent(bob,ann). 
	parent(bob,pat). 
	parent(tom,liz). 
	parent(tom,bob). 
	
Q9. What do the follwing return:

	?- parent(bob,pat).
	?- parent(liz,pat).
	?- parent(tom,ben).
	?- parent(Pam,Liz).
	?- parent(P,C),parent(P,C2).
	
	
When having the following fact:

	% lectures(X, Y): person X lectures in course Y
	lectures(turing, CSC101).
	lectures(codd, CSC226).
	lectures(backus, CSC501).
	lectures(ritchie, CSC505).
	lectures(minsky, CSC216).
	lectures(codd, CSC236).

	% studies(X, Y): person X studies in course Y
	studies(fred, CSC101).
	studies(jack, CSC226).
	studies(jill, CSC236).
	studies(jill, CSC216).
	studies(henry, CSC216).
	studies(henry, CSC236).

	% year(X, Y): person X is in year Y
	year(fred, 1).
	year(jack, 2).
	year(jill, 2).
	year(henry, 4).
	
Q10a. What is the output of `studies(henry, What). `?
	
Q10b. Write a query which will answer the question: `What student(s) in year 2 study CSC216?` And what will the answer be?
	
Q10c. Write a rule to define the property of being in year 1 and enrolled in a course.

	% year1stud(Student, Course) succeeds if Student is in year 1
	% and Student is studying Course.

		
Q11. Write rules to define a bad dog. A dog is bad if it bites the postman, chews the newspaper, or chases the cat. Make up your own predicates for biting and chewing and chasing.

		
Q12. Define a predicate sumlist(L,N) which, given a list of integers L, returns the sum N of all the elements of L.

   
   
Q13. Here is the fact named "mystery"

	mystery(A,B) :- 
	mystery(A,[],B).
	mystery([X|Y],Z,W) :- 
	mystery(Y,[X|Z],W).
	mystery([],X,X).

What's the results if we query:

	?- mystery([1,2,3], A).
