#|
A macro is a program called at runtime to write other programs.

They are used to expand shorthand into longhand.

Macros in LISP are particularly nice. LISP manipluates lists. LISP
programs are lists. LISP macros rewrite lists to add in the required
details.

For example, see below.

Note that there is much more to writing macros than shown below. For
more details, see http://www.gigamonkeys.com/book/macros-defining-your-own.html

Note also that for decades, LISP was the king of macros. Now, finally,
other languages have caught on. So JULIA has a macro system that is
(nearly) as powerful as LISP. So macros live!

|#

(defmacro aif (test then &optional else)
  "Anaphoric 'if'"
  `(let ((it ,test))
     (if it ,then ,else)))

#|
(aif (find-matching-file txt) 
     (read it) 
     'missing) 

==>

(LET ((IT (FIND-MATCHING-FILE TXT))) 
     (IF IT 
         (READ IT) 
         'MISSING))
|#

(defmacro while (test &body body)
  "implements 'while' (which is not standard in LISP)"
  `(do ()
       ((not ,test))
     ,@body))

#|
(macroexpand-1 '(while (> (decf n) 0) 
                  (print n)))

(DO NIL 
    ((NOT (> (DECF N) 0))) 
       (PRINT N))
|#

(defmacro until (test &body body)
  "implements 'until' (which is not standard in LISP)"
  `(while (not ,test)
     ,@body))

#|
(macroexpand-1 '(until (> (decf n) 0) 
                  (print n)))

(WHILE (NOT (> (DECF N) 0)) 
       (PRINT N)) ;

|#

(defmacro ? (obj first-slot &rest more-slots)
  "From https://goo.gl/dqnmvH:"
  (if (null more-slots)
      `(slot-value ,obj ',first-slot)
      `(? (slot-value ,obj ',first-slot) ,@more-slots)))

#|
(macroexpand '(? obj a b c d))

(SLOT-VALUE 
  (SLOT-VALUE 
    (SLOT-VALUE 
      (SLOT-VALUE OBJ 'A) 
      'B) 
    'C) 
  'D)
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun point (&key (x 0) (y 0))
  (labels (
     (x?   ()  x)
     (y?   ()  y)
     (x!   (z) (setf x z))
     (y!   (z) (setf y z))
     (_sq  (z) (* z z))
     (dist (x2 y2)
       (let ((x1 (x?))
             (y1 (y?)))
         (sqrt (+ (_sq (- x1 x2)) 
                  (_sq (- y1 y2)))))))
    (lambda (z &rest args)
      (case z
        (x? (x?))
        (y? (y?))
        (x! (x! (first args)))
        (y! (y! (first args)))
        (dist (dist (first args) (second args)))
        (otherwise 
          (error "~a unknown" z))))))

(defun say0 (self m &rest args) (print (apply self (cons m args))))
(defun ask0 (self m &rest args)        (apply self (cons m args)))

(let ((self (point :x 1 :y 1)))
  (format t "~%~%;--------- point ------------~%")
  (say0 self 'x?)
  (ask0 self 'x! 2)
  (say0 self 'x?)
  (say0 self 'dist 10 10)
  (print self))

;;;;;;;;;;;;;;;;;;;;
(defun make (klass  &rest args) (cons klass args))
(defun say (self m &rest args) (print (funcall (car self) self m args)))
(defun ask (self m &rest args)        (funcall (car self) self m args))

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

(let* ((klass (point2))
       (self  (make klass 1 1)))
  (format t "~%~%;--------- point2 ------------~%")
  (say self 'x?)
  (ask self 'x! 2)
  (say self 'x?)
  (say self 'dist 10 10)
  (print (cdr self)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro defobject (klass lst &rest body)
  "template for klasses"
  `(defun ,klass ()
     (labels (,@body)
       (lambda (self %z args)
         (case %z
           ,@(getsets lst)
           ,@(method-calls-with-n-args body)
           (otherwise 
             (error "~a unknown" %z)))))))

(defun getsets (lst)
  "for each instance x variable in lst,
   build a getter, setter for x? and x!"
  (let ((n -1) out)
    (labels (
      (sym (x y) (intern (string-upcase (format nil "~a~a" x y))))
      (getter (x)
              (let ((get (sym x "?"))
                    (set (sym x "!")))
                `((,get       (nth ,(incf n) (cdr self)))
                  (,set (setf (nth ,n (cdr self)) (car args)))))))
      (dolist (x lst out)
        (dolist (y (getter x))
          (push y out))))))

(defun method-calls-with-n-args (sexps &aux out)
  "work out #args each method,
   return one item for the dispatch case
   statement for each method"
  (labels (
     (arg1 (m n) 
           (when (< m n)
             (cons  `(nth ,m args) (arg1 (1+ m) n)))))
    (dolist (sexp sexps out)
      (let* ((f    (first sexp))
            (n     (length (second sexp)))
            (args  (arg1 0 (1- n)))
            (call `(,f (,f self ,@args))))
        (unless (eq #\_ (char (string f) 0))
          (push call  out))))))

; now we have a DSL!
(defobject point3 (x y)
   (_sq  (z) (* z z))
   (dist (self x2 y2)
         (let ((x1 (ask self 'x?))
               (y1 (ask self 'y?)))
           (sqrt (+ (_sq (- x1 x2)) 
                    (_sq (- y1 y2)))))))

#|

(macroexpand-1 '(defobject point3 (x y)
   (_sq  (z) (* z z))
   (dist (self x2 y2)
         (let ((x1 (ask self 'x?))
               (y1 (ask self 'y?)))
           (sqrt (+ (_sq (- x1 x2)) 
                    (_sq (- y1 y2))))))))

(DEFUN POINT3 NIL
 (LABELS
  ((_SQ (Z) (* Z Z))
   (DIST (SELF X2 Y2)
    (LET ((X1 (ASK SELF 'X?)) 
          (Y1 (ASK SELF 'Y?)))
     (SQRT (+ (_SQ (- X1 X2)) (_SQ (- Y1 Y2)))))))
  (LAMBDA (SELF %Z ARGS)
   (CASE %Z 
         (Y!   (SETF (NTH 1 (CDR SELF)) (CAR ARGS))) 
         (Y?         (NTH 1 (CDR SELF)))
         (X!   (SETF (NTH 0 (CDR SELF)) (CAR ARGS))) 
         (X?         (NTH 0 (CDR SELF)))
         (DIST (DIST SELF (NTH 0 ARGS) (NTH 1 ARGS)))
         (OTHERWISE (ERROR "~a unknown" %Z))))))

|#
(let* ((klass (point3))
       (self  (make klass 1 1)))
  (format t "~%~%;--------- point3 ------------~%")
  (say self 'x?)
  (ask self 'x! 2)
  (say self 'x?)
  (say self 'dist 10 10)
  (print (cdr self)))

