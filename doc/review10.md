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

Q1. A macro is a program called at loadtime to expand smaller things to bigger things, give two examples why this is useful.

Q2a. Languages such as C and assembly language have rudimentary text based macro systems, how do these macros work? How do these macros methods handle the scoope varilbles? Do these macro systems have access to the semantics of the underlying language?

Q2b. In the following code, there is a problem in `msg`, what is the problem?

	#define LOG(msg) ({ \
		int state = get_log_state(); \
		if (state > 0) { \
			printf("log(%d): %s\n", state, msg); \
		} \
	})

Q2c. The problem of 2b could be fixed with hygeninc macros variables. Explain how.
	
Q3a. In C pre-processing macro system, what is the following used for?

	#define M (x*x+2*x+1)
	#define BUFFER_SIZE 1024
	#define min(X, Y)  ((X) < (Y) ? (X) : (Y))
	
Q3b. `#define min(X, Y)` suffers from the repearted computation problems. Explain when is such repeated computation a problem? 

Q4. Lisp is a language where programs are expressed as lists. How does the defmacro exploit this?

Q5. In the example of Macros in Julia, 

	someFun(x::Any) = println(1000000)
	someFun(x::aa)  = println(x.bb)
	
	x    = aa0()
	x.bb = 200

Explain how to get the results when we call

	someFun(22)
	someFun(x)
	
Q6. In the following example,

	{
	  "animals": [
		{ "animalName": "beatles", "legNum": "six" },
		{ "animalName": "horse", "legNum": "four" },
		{ "animalName": "spider", "legNum": "eight" },
		{ "animalName": "snake", "legNum": "zero" }
	  ],
	  "name": function () {
		return this.animalName + " " + this.legNum;
	  }
	}
	
What are these moustaches about? Why are they useful? What is the output of these moustahses:

	{{#beatles}}
	* {{name}}
	{{/beatles}}


	{{#animals}}
	* {{name}}
	{{/animals}}

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

Q7a. This is not a class instance language. Explain why. What would be needed to make it a class instance language? 

Q7b. For the following code, what is the representations of `self`? How to generate this automatically?

	(x?         (nth 0 (cdr self)))
    (y?         (nth 1 (cdr self)))
    (x!   (setf (nth 0 (cdr self)) (nth 0 args)))
    (y!   (setf (nth 1 (cdr self)) (nth 1 args)))
	
Q7c. What information is needed to auto generate the above code?

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

Q8a. This is not an object language. Explain why. What would be needed to make it an object language? 

Q8b. In English, describe what `getsets` does. Write the exact inputs seen by `getsets`.

Q8c. In English, describe what `method-calls-with-n-args` does. Write the exact inputs seen by `method-calls-with-n-args`.

Q9. In the following examples,

	(let ((a 1)
		  (b 2)
		  (c '(10 20 30 40)))
	   (print '(a a b b))          
	   (print `(a ,a b ,b))        
	   (print `(a ,a b ,b c ,c))   
	   (print `(a ,a b ,b c ,@c))) 

What are the results of these `print`?

Q10. For the following three, describle the problem and advangeage of each approach.

	(defmacro Square-1 (X)
		`(* ,X ,X))
		
	(defmacro Square-2 (X)
		(* X X))
		
	(defmacro Square-3 (x)
  	(let ((temp (gensym)))
	  `(let ((,temp ,x))
	      (* ,temp ,temp)))
		
Q11. In the nested slot access example,

	(defmacro ? (obj first-slot &rest more-slots)
	  "From https://goo.gl/dqnmvH:"
	  (if (null more-slots)
		  `(slot-value ,obj ',first-slot)
		  `(? (slot-value ,obj ',first-slot) ,@more-slots)))
		  

How does this expand `(? obj a b c d)`?
