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

### Week 13-14 : 04/02/2018 ~ 04/09/2018

Q1. A macro is a program called at runtime to write other programs. Briefly explain what is it used for?

Q2. Languages such as C and assembly language have rudimentary macro systems, how do these macro work? (simple textual search-and-replace at the token) Do these macro systems have access to the semantics of the underlying language?

Q3. In a rudimentary macro system, what is the following used for?

	#define M (x*x+2*x+1)
	#define BUFFER_SIZE 1024
	#define min(X, Y)  ((X) < (Y) ? (X) : (Y))

Q3. In a rudimentary macro system, what's the difference between the following two?

	#define MULTIPLY(x, y) x * y
	#define MULTIPLY(x, y) (x) * (y)


Q4. Compare to many other languages, what's the advantage of LISP defmacro? (it offers the whole power of the underlying language as part of the macro system)

Q5. In the following code, there is a problem in: msg, what is the problem?

	#define LOG(msg) ({ \
		int state = get_log_state(); \
		if (state > 0) { \
			printf("log(%d): %s\n", state, msg); \
		} \
	})


Q6. What is "variable capture" problem when using macros? And how to avoid this? (hygienic macros)	

Q7. In the example of Macros in Julia, 

	someFun(x::Any) = println(1000000)
	someFun(x::aa)  = println(x.bb)
	
	x    = aa0()
	x.bb = 200

Explain how to get the results when we call

	someFun(22)
	someFun(x)
	
Q8. In the following example,

	{{#beatles}}
	* {{name}}
	{{/beatles}}

What are these mass dash about? Why are they useful?  (everything in mas dash is "for each, do" ,have no if)

In OO Version2 examples,

	(defun point2 ()
	  (labels (
		 (_sq  (z)      (* z z))
		 (dist (self x2 y2)
		   (let ((x1 (ask self 'x?))
				 (y1 (ask self 'y?)))
			 (sqrt (+ (_sq (- x1 x2)) 
					  (_sq (- y1 y2)))))))
		(lambda (self z args)
		  (case z
			(x?         (nth 0 (cdr self)))
			(y?         (nth 1 (cdr self)))
			(x!   (setf (nth 0 (cdr self)) (nth 0 args)))
			(y!   (setf (nth 1 (cdr self)) (nth 1 args)))
			(dist (dist self (first args) (second args)))
			(otherwise 
			  (error "~a unknown" z))))))

Q9a. What happened if I call dist? (labels do nested methods in lisp.)

Q9b. How to generate this automatically:

	(x?         (nth 0 (cdr self)))
    (y?         (nth 1 (cdr self)))
    (x!   (setf (nth 0 (cdr self)) (nth 0 args)))
    (y!   (setf (nth 1 (cdr self)) (nth 1 args)))
	
In OO Version3 examples,

	(defmacro defklass (klass lst &rest body)
	  "template for klasses"
	  `(defun ,klass ()
		 (labels (,@body)
		   (lambda (self %z args)  ; using %z is a hygiene cheat
			 (case %z
			   ,@(getsets lst)
			   ,@(method-calls-with-n-args body)
			   (otherwise 
				 (error "~a unknown" %z)))))))

Q10a. What is returned by `"template for klasses"`?

Q10b. What is `,@(getsets lst)` used for? What args it takes? What does it return?

Q11. In the following examples,

	(let ((a 1)
		  (b 2)
		  (c '(10 20 30 40)))
	   (print '(a a b b))          ; ==> (A A B B)
	   (print `(a ,a b ,b))        ; ==> (A 1 B 2)
	   (print `(a ,a b ,b c ,c))   ; ==> (a 1 b 2 c (10 20 30 40))
	   (print `(a ,a b ,b c ,@c))) ; ==> (a 1 b 2 c 10 20 30 40)

Why are the last two print different?

Q12. What is the potential problem in the following macros?

	(defmacro Square-1 (X)
		`(* ,X ,X))
		
	(defmacro Square-2 (X)
		(* X X))
		
Q13. In the nested slot access example:

	(defmacro ? (obj first-slot &rest more-slots)
	  "From https://goo.gl/dqnmvH:"
	  (if (null more-slots)
		  `(slot-value ,obj ',first-slot)
		  `(? (slot-value ,obj ',first-slot) ,@more-slots)))
		  
What is going on in the last row?
