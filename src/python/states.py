# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
import re,traceback,time,sys,time

#----------
def kv(d):
  """Return a string of the dictionary,
     keys in sorted order,
     hiding any key that starts with '_'"""
  return '{' + ', '.join(['%s: %s' % (k, d[k])
                          for k in sorted(d.keys())
                          if k[0] != "_"]) + '}'


d= dict(lname='menzies', fname='tim', _secrets=57)
print(d)
print(kv(d))

sys.exit()
#-----------------------------------
# getting meta (and recursive walks)

class A(object):
  tag="*"
class B(A):
  tag="-"
class C(A):
  tag="/"
class D(B,C): # D has two parents... that way, madness lies
  tag="."
class E(D):
  tag="!"

def isa(k, seen = None):
  assert isinstance(k, type),"superclass must be 'object'"
  seen = seen or set()
  if k  not in seen:
    #_seen.add(k)
    yield k
    for sub in k.__subclasses__():
      for x in isa(sub, seen):
        yield x


for x in isa(A):
  print(x.__name__, x.tag)

print([x.tag for x in isa(A)])

sys.exit()

# function data
def about(f):
  print("\n-----| %s |-----------------" % f.__name__)
  if f.__doc__:
    print("# "+ re.sub(r'\n[ \t]*',"\n# ",f.__doc__))

# time it
def run(f):
  about(f)
  t1= time.time()
  f()
  t2= time.time()
  print(":msec", int(round((t2 - t1) * 1000)))
  return f

def fib1(n):
  return n if n < 2 else fib1(n-2) + fib1(n-1)

# these two lines
def fib1a(): print(30, fib1(30))
run(fib1a)

#are the same as these two lines
@run
def fib1a(): print(30, fib1(30))
#@run
def fib1b(): print(33, fib1(33))
#@run
def fib1c(): print(36, fib1(36))
#@run
def fib1d(): print(39, fib1(39))

def memo(f):
  cache={}
  def g(*lst, **dic):  
    if lst in cache:
      return cache[lst]
    new = cache[lst] = f(*lst, **dic)
    return new
  return g

@memo
def fib2(n):
  return n if n < 2 else fib2(n-2) + fib2(n-1)

@run
def fib2a(): print(30, fib2(30))
@run
def fib2b(): print(100, fib2(100))
@run
def fib2b(): print(500, fib2(500))

#--- unittest engine... in 11 lines 
TRY=FAIL=0
def ok(f=None):
  global TRY,FAIL
  if f:
    try:    TRY  += 1; about(f); f(); print("# pass"); 
    except: FAIL += 1; print(traceback.format_exc());
    return f
  else:
    print("\n# %s TRY= %s ,FAIL= %s ,%%PASS= %s"  % (
      time.strftime("%d/%m/%Y, %H:%M:%S,"),
      TRY, FAIL, 
      int(round((TRY - FAIL)*100/(TRY+0.001)))))

# testing the test engine
@ok
def test0(): assert True
@ok
def test1(): assert False,"everything is wrong"

ok()
