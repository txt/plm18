# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
from __init__ import *
import sys

# usage:
#   python fsm.py 21083 # for a long-ish run
#   python fsm.py 1     # for a short run



# ----------------------------------------------
def fsm0(label):
  m     = Machine(label)
  entry = m.S("entry")  # first names state is "start"
  foo   = m.S("foo")
  bar   = m.S("bar")
  stop  = m.S("stop.")  # anything with a "." is a "stop"
  #-- machine
  m.T(entry, walk, foo)
  m.T(foo,   walk, foo)
  m.T(foo,   sit,  stop)
  return m
 
# ----------------------------------------------
def walk(w, a):  return maybe()
def sit(w, a):   return maybe()
def ok(w, a):    return True
def fail(w, a):  return maybe()
def again(w, a): return maybe()

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

print(bcolors.OKBLUE + """
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

""" + bcolors.ENDC)

fsm0(1)
fsm0(2)
fsm0(4)
if len(sys.argv) > 1:
  Machine.run(int(sys.argv[1]))
else:
  Machine.run()
