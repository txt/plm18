# vim: set filetype=python ts=2 sw=2 sts=2 expandtab: 
# note above: enforce indentation standards

#-----------------------------------------------------
# decorators
import re
def go(f):
  print("\n#--|",f.__name__,"|------------------------")
  if f.__doc__:
    print("# "+ re.sub(r'\n[ \t]*',"\n# ",f.__doc__))
  f()
  return f

@go
def go1():
  """Isn't it great we can
  use the function doco string to
  document the test? """
  print("going!")

#-----------------------------------------------------
# memoisation via decoration
def memo(f):
  cache={}
  def g(*lst, **dic):
    if lst in cache:
      return cache[lst]
    new = cache[lst] = f(*lst, **dic)
    return new
  return g

@memo
def fib(n):
  return n if n < 2 else fib(n-2) + fib(n-1)

#@go
def fibEg():
  "without memoization, this will never terminate"
  print(fib(200))

#-----------------------------------------------------
# list comprehensions

@go
def compEg():
  s = [x**2 for x in range(10)]
  v = [2**i for i in range(13) ]
  m = [x/10 for x in s if x % 2]
  print(dict(s=s,v=v,m=m))

#-----------------------------------------------------
# iterators
def items(x):
  if isinstance(x,(list,tuple)):
    for y in x:
      for z in items(y):
        yield z
  else:
    yield x

#@go
def items1():
  for i in items([10, 20, [30, [40, 50]], [60, 70], 80]):
    print(i)

#-----------------------------------------------------
# context manager
from contextlib import contextmanager
@contextmanager
def tag(s):
  print("<"+s+">",end="")
  yield;
  print("</"+s+">",end="")

#@go
def tagEg():
  with tag("h1"):
    print( "hello",end="")
    with tag("em"):
      print("timm",end="")

#-----------------------------------------------------
# abstraction
def str2lines(str):
  for line in str.splitlines():
    yield line

def file2lines(file):
  with open(file) as fs: # context manager
    for line in fs:
      yield line.rstrip('\n')

import zipfile
def zip2lines(file):
  with zipfile.ZipFile(file) as z:
    with z.open(file) as f:
      for line in f:
        yield line.rstring('\n')

def lines(str):
  "returns an iterator"
  def ext()  : return str[-3:]
  def zip()  : return ext() == "zip"
  def file() : return ext() in [".py", "csv", "txt"]
  # --- begin main ------------------
  if  file() : return file2lines(str)
  elif zip() : return zip2lines(str)
  else       : return str2lines(str)

#@go
def linesEg1():
  for line in lines("""111 
                    222
                    333"""):
    print(line)

#@go
def linesEg2():
  for line in lines("idiom.py"):
    print("\t",line)

#-----------------------------------------------------
# csv reader
def csv(src):
  """kill whitespace, comments, skip blanklines, 
     return list of cells, one per line"""
  for line in lines(src):
    line = re.sub(r'([\n\t\r ]|#.*)', '', line)
    if line:
      line= [z.strip() for z in line.split(",")]
      if line:
        yield  line

str001="""forecast,temp,humidity, ?windy, play
          #------- ---- --------  -----  -----
          ?,     85, ?,  false, no
          sunny, 72, 95.0, false, no
          sunny, 80, 90, true,  no # comments
          rainy, 65, 70, true,  no
          rainy, 71, 91, true,  no
          overcast, 83, 86, false, yes
          rainy, 70, ?, false, yes

          rainy, 68, 80, false, yes
          # another comment
          overcast, 64, 65, true, yes
          sunny, 69, 70, false, yes
          rainy, 75, 80, false, yes
          sunny, 75, 70, true, yes
          overcast, 72, 90, true, yes
          overcast, 81, 75, false, yes"""

#@go
def csvEg():
  for cells in csv(str001):
    print(cells)

def thing(x):
  def sym(x): return x
  try:    
    return int(x), int
  except: 
    try:    return float(x),float
    except: return x,sym

#-----------------------------------------------------
# columns reader
def cols(src):
  """ Cols have meta-knowledge. Meta-K starts life as
      'None'. Then, when the first non empty cells shows up,
      they are converted to 'int' or 'sym' or 'float'.
  """
  meta = None
  # --- utils -----------------
  def cols1(line,c, cell, f):
    if line == 0   : return cell
    if cell == "?" : return cell
    if f           : return f(cell)
    cell, meta[c] = thing(cell)
    return cell
  # --- main ------------------
  for line,cells in enumerate(csv(src)):
    meta = meta or { 
            c:None for c,cell in enumerate(cells) if cell[0] != "?" }
    yield [ cols1(line, c, cells[c], meta[c]) for c in meta ]

@go
def colsEg():
  for cells in cols(str001):
    print(cells)

#def fileLines(file):
#      
#      line = re.sub(r'([\n\r\t]|#.*)', "", line)
#      row = map(lambda z:z.strip(), line.split(","))
#      if len(row)> 0:
#        yield prep(row) if prep else row
#

#@go
def linesEg1():
  """Lets say what we are doing abd say so using
  several lines of
  test"""
  lines("asasads.txt")
