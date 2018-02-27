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

### Week 7 : 02/20/2018 ~ 02/22/2018

Q1. Here are the 7 primitive operators of Lisp, for each, define it and give an example of its use. 

	a. (quote x)
	
	b. (atom x)
	
	c. (eq x y)
	
	d. (car x)
	
	e. (cdr x)
	
	f. (cons x y)
	
	g. (cond (p{1}...e{1}) ...(p{n}...e{n}))

Q2. Define S expression and give 4 examples ranging from very simple to very complex.

Q3. How to represent true/false in Lisp?

Q4. What are lambda expressions? What is their purpose in Lisp?

Q5. What is the result of each of the following calls? If the expression results in an error, explain why.

	a. (CAR '((A B) (C D)) )

	b. (CDR '((A B) (C D)) )

	c. (CONS '(A B) '(C D))

	d. (EQ '(A B) '(A B) )

	e. (ATOM ( ) )

	f. (list (+ 1 2) '(+ 1 2))

	g. (cons (+ 1 2) '(3 4))

	h. (reverse (append '(1 2) '(3 4)))

	i. (remove-if #'(lambda (x) (>= x 10)) '(11 10 9 5 15 6 0))

	j. (+ 10 (car '((1) (2) (3))))

Q6. What does the following code return? 

	a. (mapcar #'(lambda (x) (+ x 2)) '(1 2 3 4 5))

	b. (funcall (lambda (a b c) (+ a b c))
		1 (* 2 3) (- 5 4))

Q7. What does the following code return?

	(write ((lambda (a b c x)
		(+ (* a (* x x)) (* b x) c))
		4 2 9 3)
	)

Q8. Describe the outputs for each step:

	(define (adder n) (lambda (x) (+ x n)))

	((adder 8) 7)

	(define (doubler f) (lambda (x) (f x x)))

	((doubler +) 15)

Q9. How to write the following code in Lisp?

	if a then b 
	else if c then d

Q10. Implement the following functions by using Lisp lambda function:

	a. Given x=3, y=2, z=1, write the Lisp lambda function to calculate x*3 - y*2 + z

	b. Given x=3, write the Lisp lambda function to calculate x^3 + x^2 + 1

	c. What is Lisp lambda function to subtract 7 from a number (a parameter n)?

