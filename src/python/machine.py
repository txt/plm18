# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
import sys
sys.dont_write_bytecode = True

from lib import shuffle,Pretty,o,rseed,between
# alt form: 
# from lib import *

# ----------------------------------------------
def transistion(here,gaurd,there):
    "No methods inside T. just use 'o'"
    return o(here=here,gaurd=gaurd,there=there)

T=transistion

class State(Pretty):
  def __init__(i, name):
    i.name, i.out, i.visits = name, [], 0

  def stop(i):
    return i.name[-1] == "."

  def looper(i):
    return i.name[0] == "#"

  def arrive(i):
    if not i.looper():
      i.visits += 1
      assert i.visits <= 5, 'loop detected'

  def next(i, w):
    for tran in shuffle(i.out):
      if tran.gaurd(w, tran):
        return tran.there
    return i

 

class Machine:
  Factory = []  # considered making it a class but it only has one method

  def __init__(i,label):
    i.states = {}
    i.first = i.here = None  # i.here now an instance var
    i.name = label
    i.pos = 0
    Machine.Factory.append(i)

  def trans(i, *trans):
    for tran in trans:
      tran.here.out += [tran]

  def S(i,txt): 
    return i.state(txt)

  def T(i,here,gaurd,there): 
    i.trans(o(here=here, gaurd=gaurd,there=there))

  def state(i, txt):
    tmp = State(txt)
    i.states[txt] = tmp
    i.first = i.first or tmp
    i.here  = i.here  or tmp
    return tmp

  @staticmethod
  def run(seed=1, ticks=100):
    print('#', seed)
    rseed(seed)
    w = o(now=0)
    while w.now < ticks:
      alive = False
      for machine in shuffle(Machine.Factory):
        if not machine.here.stop():
          alive = True
          w.now += 1
          machine.step(w)
          Machine.report(machine.name)
          break
      if not alive: break

    return w

  @staticmethod
  def report(name):
    max_len = 50
    lst = [0]*(max_len+1)
    for machine in Machine.Factory:
      lst[machine.pos] += machine.name
    show = lambda x : str(x if x else ".")
    print(name," | ", " ".join([show(x) for x in  lst]))

  def step(i, w): 
    if not i.here.stop():
      i.here = i.here.next(w)
      i.here.arrive()
      i.pos = (i.pos + move()) % 50


def move(): return between(-10, 10)
