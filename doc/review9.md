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

### Week 11 : 03/27/2018 ~ 03/29/2018

Q1. In DSLs, why Racket almost never uses classes? 

Q2. What is the difference between object-based system and class-based system?

Q3. There are two ways to build a DSL: External and Internal, briefly explain what they are and give an example for each of them.

Q4. Some python tools can be used for DSLs, decorator for example, explain how to use it as a test engine.

Q5a. What is context manager? And what is the following say?

Q5b.

	def duration():
		t1 = time.time()
		yield
		t2 = time.time()
		print("\n" + "-" * 72)
		print("# Runtime: %.3f secs" % (t2-t1))
		
Q5c.

	def closing(thing):
		try:
			yield thing
		finally:
			thing.close()
			
In the following code:

	  def step(i,dt,t,u,v):
		def saturday(x): return int(x) % 7 == 6
		v.C +=  dt*(u.q - u.r)
		v.D +=  dt*(u.r - u.s)
		v.q  =  70  if saturday(t) else 0 
		v.s  =  u.D if saturday(t) else 0
		if t == 27: # special case (the day i forget)
		  v.s = 0

		  draw diagram, change something
		  
		  
Q6a. How do we get the constants of dict?

Q6b. What are i, dt, t respectively?

Q6c. How to represent payload in the code?

Q6d. How to update the field of v?
	
Q7. For the following example, write a compartmental model.

```
 q   +-----+  r  +-----+
---->|  C  |---->|  D  |--> s
 ^   +-----+     +-+---+
 |                 |
 +-----------------+ 

C = stock of clean diapers
D = stock of dirty diapers
q = inflow of clean diapers
r = flow of clean diapers to dirty diapers
s = out-flow of dirty diapers
```
	
Q8. What is the difference between Stocks and Flows in Compartmental Modeling?

Q9. In Compartmental Modeling, what are auxillary variables used for?

Q10. Why would a stock need this?

	  def restrain(i,x):
		return max(i.lo, 
            min(i.hi, x))
			
In class "model":

	class Model:
	  def state(i):
		"""To create a state vector, we create 
		one slot for each name in 'have'."""
		tmp=i.have()
		for k,v in tmp.has().items():
		  v.name = k
		return tmp 
	  def run(i,dt=1,tmax=30):
		"""For time up to 'tmax', increment 't' 
		   by 'dt' and 'step' the model."""
		t,b4 = 0, o()
		keep = []    ## 1
		state = i.state()
		for k,a in state.items(): 
		  b4[k] = a.init
		keys  = sorted(state.keys(),  ## 3
					   key=lambda z: state[z].rank())
		keep = [["t"] +  keys,
				[0] + b4.asList(keys)]
		while t < tmax:
		  now = b4.copy()
		  i.step(dt,t,b4,now)
		  for k in state.keys(): 
			now[k] = state[k].restrain(now[k]) ## 4
		  keep += [[t] + now.asList(keys)] ## 2
		  t += dt
		  b4 = now
		return keep

Q11a. What is keep = []?

Q11b. What is happending here:

      for k in state.keys(): 
        now[k] = state[k].restrain(now[k]) ## 4

Q11c. What returns here: 

	  keep += [[t] + now.asList(keys)] ## 2

In the following code about "printm":

	def printm(matrix,less=True):
	   """Print a list of list, only showing changes
	   in each column (if less is True)."""
	   def ditto(m,mark="."):
		 def worker(lst):
		   out = []
		   for i,now in enumerate(lst):
			 before = old.get(i,None) # get old it if exists
			 out += [mark if before == now else now]
			 old[i] = now # next time, 'now' is the 'old' value
		   return out # the lst with ditto marks inserted
		 old = {}
		 return [worker(row) for row in m]
	   matrix = ditto(matrix) if less else matrix
	   s = [[str(e) for e in row] for row in matrix]
	   lens = [max(map(len, col)) for col in zip(*s)]
	   fmt = ' | '.join('{{:{}}}'.format(x) for x in lens)
	   for row in [fmt.format(*row) for row in s]:
		  print(row)
		  
Q12. What do these two lines do:

	   s = [[str(e) for e in row] for row in matrix]
	   lens = [max(map(len, col)) for col in zip(*s)]

Q13. For Compartmental Models, why we do not try to debug complex emergent behavior?

Q14. Instead of debugging complex emergent behavior, what we can do?

Q15. Label the models below:
 
![cmnl](https://cloud.githubusercontent.com/assets/1433964/10382538/12b9265c-6df3-11e5-8572-7b60661e4464.jpg)
