(defmacro == (x y)  `(setf ,x ,y))
(defmacro += (x y)  `(setf ,x  (+ ,x ,y)))

(defun step (d  dt t)
  (with-slots (q r s c1 d1 q1 s1 ud) d
      (+= v1 (* dt (- q r)))
      (+= d1 (* dt (- r s)))
      (== q  (if (saturday t) 70 0))
      (== s  (if (saturday t) d 0))
      (if (= t 26)
          (== s 0))))
      
(defmethod saturday ((d diapers) x)
  (eql 6 (mod x 7)))



  def have(i):
    return o(C = S(100), D = S(0),
             q = F(0),  r = F(8), s = F(0))

  def step(i,dt,t,u,v):
    def saturday(x): return int(x) % 7 == 6
    v.C +=  dt*(u.q - u.r)
    v.D +=  dt*(u.r - u.s)
    v.q  =  70  if saturday(t) else 0 
    v.s  =  u.D if saturday(t) else 0
    if t == 27: # special case (the day i forget)
      v.s = 0




