# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
from __init__ import *
import sys

# usage:
#   python fsm.py 21083 # for a long-ish run
#   python fsm.py 1     # for a short run



# ----------------------------------------------
def fsm0(s,t):
  foo = s("foo")
  t("entry", walk, foo)
  t(foo,     walk, foo)
  t(foo,     sit,  "stop.")
 
# ----------------------------------------------
def walk(w, a):  return maybe()
def sit(w, a):   return maybe()
def ok(w, a):    return True
def fail(w, a):  return maybe()
def again(w, a): return maybe()

print(LITE.BLUE + """
         ,     ,
        (\____/)
         (_oo_)
          (O)
        __||__    \)
     []/______\[] /
      / \______/ \/
    /    /__\ 
   (\   /____\ 

Welcome to .... the machine.

""" + LITE.END)

factory = []
factory = grow(factory,fsm0, factory, 1,2,4)

if len(sys.argv) > 1:
  Machine.run(all, int(sys.argv[1]))
else:
  Machine.run(all)
