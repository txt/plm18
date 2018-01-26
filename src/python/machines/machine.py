# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
import sys
sys.dont_write_bytecode = True

from lib import shuffle,Pretty,o,rseed,between
# alt form: 
# from lib import *

# ----------------------------------------------

def grow(factory,,f,ako,*labels,**pairs):
  for label in labels:
    grow1(f,ako,label,factory)
  for ako1,label in pairs:
    grow1(f,ako1,label,factor)
  return factory

def grow1(f,ako,label,factory):
  m = Machine(label)
  factory += [m]
  s = lambda x  : m.state(x,ako=ako)
  t = lambda x,y,z: m.trans(x,y,z)
  f(s,t)

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

  def __init__(i,label, all):
    i.states = {}
    i.first = i.here = None  # i.here now an instance var
    i.name = label
    i.pos = 0
    i.last = State
    all.append(i)

  def trans(i, go,gaurd,end):
    tran.here.out += [o(here  = i.find(go), 
                        gaurd = gaurd, 
                        there = i.find(end)]

  def find(i,x):
    if isinstance(x,State): 
      return x
    else:
      return i.states if x in i.states else i.state(x)

  def state(i, txt,ako=None):
    ako    = ako if ako else i.last
    i.last = ako
    tmp    = ako(txt)
    i.states[txt] = tmp
    i.first = i.first or tmp
    i.here  = i.here  or tmp
    return tmp

  @staticmethod
  def run(all,seed=1, ticks=100):
    print('#', seed)
    rseed(seed)
    w = o(now=0)
    while w.now < ticks:
      alive = False
      for machine in shuffle(all):
        if not machine.here.stop():
          alive = True
          w.now += 1
          machine.step(w)
          Machine.report(all,machine.name)
          break
      if not alive: break

    return w

  @staticmethod
  def report(all,name):
    max_len = 50
    lst = [0]*(max_len+1)
    for machine in all:
      lst[machine.pos] += machine.name
    show = lambda x : str(x if x else ".")
    print(name," | ", " ".join([show(x) for x in  lst]))

  def step(i, w): 
    if not i.here.stop():
      i.here = i.here.next(w)
      i.here.arrive()
      i.pos = (i.pos + move()) % 50


def move(): return between(-10, 10)
