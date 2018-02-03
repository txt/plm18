# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
"""

Read the test case at the bottom (sym1)
to understand what this code does.

Copy this file.

Fill in the missing bits Q1,Q2,Q3,Q4,Q5
between <BEGIN> and <END>.
Warning: Q5 ain't easy.
Try not to touch the rest of the code.

Run this code as follows:

    python3 sym.py

You should see the follwing output:

  $ python3 sym.py

  -----| sym1 |-----------------
  # pass

  # 01/02/2018, 21:59:42, TRY= 1 ,FAIL= 0 ,%PASS= 100

Submit your answer to moodle before class on Tueday.

Have fun!

"""
import re,traceback,time,random

def rseed(seed=1):
  random.seed(seed)

def about(f):
  print("\n-----| %s |-----------------" % f.__name__)
  if f.__doc__:
    print("# "+ re.sub(r'\n[ \t]*',"\n# ",f.__doc__))

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

#########################################################
#<BEGIN>

class Sym(object):
  def __init__(i, inits=None):
    i.counts= {}   # track total of things seen so far
    i.most  = 0    # track number of most common thing
    i.mode  = None # track value of most common thing
    i.total = 0    # count of totl things seen so far
    i.adds(inits or []) # if any inits, add them in
  def __repr__(i):
    "print a represtation of the Sym"
    # Q1
  def __imul__(i,x): i.adds(x); return i
  def __iadd(i,x):   i.add(x) ; return i
  def adds(i,lst):  
    "call add for each item in lst"
    # Q2
  def add(i,x):
    """increment total by one
        increat counts of x by one
       if new cost common symbol, update mode,most"""
    # Q3
  def prob(i,x):
    "return probability of x, given the frequencies in counts"
    # Q4
  def sample(i, enough=500):
    """Iterator.  Yields often seen things most often
     while yielding rarer this more rarely.
      Given a dictionary d{k1=n1, k2=n2, ...},
      return enough keys ki at probability
      pi = ni/total where total = n1+n2+..
      e.g. if we've seen 30 boxes and 20 circles
      and 10 lines, then this code should
      yield
      around twice as many boxes as anything else,
      circles 1/3rd of the time and lines 1/6th of the time.
    """
    #Q5

#<END>
####################################
@ok
def sym1():
  rseed()
  s1 = Sym('programming is fun')
  assert s1.total == 18
  assert s1.mode in 'rgmin ' # rgmin<space> is the most common symbol
  assert s1.most == 2      # each of rgmin<spance> appear twive
  assert s1.prob('g') == 2/18
  # and if we sample from s1...
  s2 = Sym( [x for x in s1.sample(1000)] )
  # ... then we should see more 'm' than 'f'
  assert s2.counts['m'] > s2.counts['f']*1.5

if __name__== "__main__":
  ok()

