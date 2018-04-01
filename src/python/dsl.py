from dsllib     import o,r,ok,oks,printm
from dslmonitor import Monitor

class Has:
  def __init__(i,init,lo=0,hi=100):
    i.init,i.lo,i.hi = init,lo,hi
  def restrain(i,x):
    return max(i.lo, 
               min(i.hi, x))
  def rank(i): 
    "Trick to sort together columns of the same type."
    return 0
  def __repr__(i):
    return str(dict(what=i.__class__.__name__,
                name= i.name,init= i.init,
                 lo  = i.lo,  hi  = i.hi))
                 
class Flow(Has) :
  def rank(i): return 3
class Stock(Has):
  def rank(i): return 1
class Aux(Has)  :
  def rank(i): return 2

S,A,F = Stock,Aux,Flow

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

class Diapers(Model):
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

@ok
def _diapers1():
  printm(Diapers().run())
