import sys,random,traceback

r   = random.random
isa = isinstance

PASS=FAIL=0
VERBOSE=True

def oks():
  global PASS, FAIL
  print("\n# PASS= %s FAIL= %s %%PASS = %s%%"  % (
          PASS, FAIL, int(round(PASS*100/(PASS+FAIL+0.001)))))

def ok(f):
  global PASS, FAIL
  try:
      print("\n-----| %s |-----------------------" % f.__name__)
      if f.__doc__:
        print("# "+ re.sub(r'\n[ \t]*',"\n# ",f.__doc__))
      f()
      print("# pass")
      PASS += 1
  except Exception as e:
      FAIL += 1
      print(traceback.format_exc())
  return f

class o:
  """Emulate Javascript's uber simple objects.
  Note my convention: I use "`i`" not "`this`."""
  def has(i)             : return i.__dict__
  def keys(i)            : return i.has().keys()
  def items(i)           : return i.has().items()
  def __init__(i,**d)    : i.has().update(d)
  def __setitem__(i,k,v) : i.has()[k] = v
  def __getitem__(i,k)   : return i.has()[k]
  def __repr__(i)        : return 'o'+str(i.has())
  def copy(i): 
      j = o()
      for k in i.has(): j[k] = i[k]
      return j
  def asList(i,keys=[]):
    keys = keys or i.keys()
    return [i[k] for k in keys]

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



