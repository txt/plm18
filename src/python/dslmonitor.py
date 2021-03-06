from dsllib import ok,oks

class Num:
  "An Accumulator for numbers"
  def __init__(i,inits=[]): 
    i.n = i.m2 = i.mu = 0.0
    for x in inits: i.add(x)
  def s(i): return (i.m2/(i.n - 1))**0.5
  def add(i,x):
    i.n   += 1  
    delta  = x - i.mu
    i.mu  += delta*1.0/i.n
    i.m2  += delta*(x - i.mu)
  def same(i,j, conf=0.95,small=0.38):
    return i.tTest(j, conf) and i.hedges(j, small)
  def tTest(i,j,conf=0.95):
    nom   = abs(i.mu - j.mu)
    s1,s2 = i.s(), j.s()
    denom = ((s1/i.n + s2/j.n)**0.5) if s1+s2 else 1
    df    = min(i.n - 1, j.n - 1)
    return  criticalValue(df, conf) >= nom/denom
  def hedges(i,j,small=0.38):
    num   = (i.n - 1)*i.s()**2 + (j.n - 1)*j.s()**2
    denom = (i.n - 1) + (j.n - 1)
    sp    = ( num / denom )**0.5
    delta = abs(i.mu - j.mu) / sp  
    c     = 1 - 3.0 / (4*(i.n + j.n - 2) - 1)
    return delta * c < small

def criticalValue(df,conf=0.95,
  xs= [            1,     2,     5,    10,    15,    20,    25,   30,     60,  100],
  ys= {0.9:  [ 3.078, 1.886, 1.476, 1.372, 1.341, 1.325, 1.316, 1.31,  1.296, 1.29], 
       0.95: [ 6.314, 2.92,  2.015, 1.812, 1.753, 1.725, 1.708, 1.697, 1.671, 1.66], 
       0.99: [31.821, 6.965, 3.365, 2.764, 2.602, 2.528, 2.485, 2.457, 2.39,  2.364]}):
  def interpolate(x,xs,ys):
    if x <= xs[0] : return ys[0]
    if x >= xs[-1]: return ys[-1]
    x0, y0 = xs[0], ys[0]
    for x1,y1 in zip(xs,ys):  
      if x < x0 or x > xs[-1] or x0 <= x < x1: break
      x0, y0 = x1, y1
    gap = (x - x0)/(x1 - x0)
    return y0 + gap*(y1 - y0)
  return interpolate(df, xs, ys[conf])

@ok
def _hedge():
  for p in [1.2, 1.3, 1.4, 1.5]:
    for d in [0,0.05,0.1,0.15,0.2,0.25]:
      i = Num([1,2,3,4,5,6,7,8,9,10])
      j = Num([ p * (x -d) for x in [ 1,2,3,4,5,6,7,8,9,10]])
      print("%5s %4.2f %4.2f" % (i.same(j) ,p, d))

class Minitor(o):
  def __init__(i, keys, decimals=3, steps=10, sep=' | ',key=lambda z:z):
    i.decimals = decimals
    i.sep = sep
    sorted(keys,key=key)
    i.keys=keys
    i.widths=[len(k) for k in keys]
    i.shows=[]
    i.last = []
    i.now  = [Num() for _ in keys]
    i.step = i.steps= steps
  def show(i, vals):
    tmp=[]
    for n,(val,width) in enumerate(zip(vals, i.widths)):
      tmp += [ max( len(str(val)), width) ]
    i.widths= tmp
    shows = [ '%%>%s.%sf' % (w,i.decimals) for w in i.widths]
    return i.sep.join([show % val for 
                       show,val in zip(shows, vals)])
  def __add__(i, d):
    for k in i.keys: 
      i.nows[k].add(d[k])
    i.step -= 1
    if i.step == 0:
      i.step = i.steps
      if i.last:
        vals=[( '.' if i.last[k].same(i.nows[k]) else i.nows[k].mu) for k in i.keys]
      else:
        vals = [i.nows[k].mu for k in i.keys]
      print(i.show(vals))
      i.last = i.nows
      i.nows = [Num() for _ in i.keys]

  def show(i, vals):
    sep=""
    for w,v in zip(i.widths,vals):
        
  def __add__(i, d)
    for 
