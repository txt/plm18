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

(defun z1 (&rest lst)
  (let ((n -1))
    (labels ((sym (x y) (intern (string-upcase (format nil "~a~a" x y))))
             (sym? (x)  (sym x "?"))
             (sym! (x)  (sym x "!"))
             (getter (x)
                     (let ((get (sym? x))
                           (set (sym! x)))
                       `((,get       (nth ,(incf n) (cdr self)))
                         (,set (setf (nth ,n (cdr self)) v))))))
      (mapcar #'getter lst))))

;(dolist (x (z1 'a 'b 'c)) (print x))

