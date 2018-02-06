# vim: set filetype=python ts=2 sw=2 sts=2 expandtab:

import sys,re

def go(f):
  print("\n#", f.__name__)
  f()
  return f

#---| lib stuff |------

def say(x):
  sys.stdout.write(x)

#--- interpreter for reverse polish notation
# https://en.wikipedia.org/wiki/Reverse_Polish_notation

def postorder(x):
  def worker(x,out):
    leaf  = lambda y: not isinstance(y,list)
    left  = lambda y: y[0]
    head  = lambda y: y[1]
    right = lambda y: y[2]
    if leaf(x):
      out += [x]
    else:
      worker(left(x), out)
      worker(right(x),out)
      worker(head(x), out)
    return out
  # ---------------
  return worker(x,[])

#@go
def _postorder():
  print(postorder( [[1, "+",2],
                    "*",
                    [2, "-", 3]] ))

#-----------------------------------------
# evaluator for rpn
                     
def rpn(input):
  minus    = lambda x,y : float(x) - float(y)
  plus     = lambda x,y : float(x) + float(y)
  mult     = lambda x,y : float(x) * float(y)
  args     = {"+" : plus, 
              "*" : mult, 
              "-" : minus}
  operator = lambda x: x in args
  stack    = []
  while input:
    token = input.pop(0)
    if not operator(token):
      stack += [token]
    else:
      two = stack.pop()
      one = stack.pop()
      f= args[token]
      stack += [f(one,two)]
  return stack[0]

@go
def _shunt():
  say("5 + ((1 + 2) * 4) - 3 = " )
  print(rpn([5,1,2,"+",4,"*","+",3,"-"]))

# -------------------------------------------
# infix to rpn translator

# class stuff definitions

class Op:
  all = []
  def __init__(i,name,precedence=100):
    i.name=name
    i.precedence = precedence
    Op.all += [i]
  def __repr__(i):
    return i.name + '{' + str(i.precedence) + '}'
 
# parsing utils 
def isa(x):
  "Try to find the operator names 'x'. Else fail."
  for y in Op.all:
    if x == y.name: return y
  return None
    
def isNum(x):
  "Let Python do the heavy lifting"
  try: return int(x)
  except ValueError:
    try: return float(x)
    except ValueError:
      return None

# main engine 
class Shunt:
  """ Simple version of Edsger Dijkstra's shunting yard algorithm.
      No associativity, brackets, function symbols, arguments.
      No error checking.
      For full version, see http://goo.gl/pakbVu
  """
  def __init__(i,str):
    say(str + ' : \n')
    i.out   = []
    i.stack = []
    for token in i.tokens(str): 
      i.shunt(token)
    # tidy up
    while i.stack: i.up()
  def __repr__(i)   : return str(i.out)
  def over(i,token) : say("\to\n"); i.out   += token
  def down(i,op)    : say("\td\n"); i.stack += [op]
  def up(i)         : say("\tu\n"); i.out   += [i.stack.pop()] 
  def somethingIsMoreImportant(i,op):
    return i.stack and op.precedence <= i.stack[-1].precedence
  def tokens(i,str): 
    "dumb tokenizer: assumes tokens one char wide)"
    return list(re.sub("[ \t]*","",str)) 
  def shunt(i,token):
    op = isa(token)
    say(token)
    if not op:
      i.over(token)
    else:
      while i.somethingIsMoreImportant(op):
        i.up()
      i.down(op)
  
# demos
@go
def _shunt():
  Op.all = []
  Op('+',1)
  Op('*',2)
  Op('/',2)
  print(Shunt("1 + 2"))        # 1 2 +
  print(Shunt("1 + 2 + 3"))    # 1 2 + 3 +
  print(Shunt("1 + 2 / 3"))    # 1 2 3 / +
  print(Shunt("a * b + c / d")) # a b * c d / +
  print(Shunt("a * b + c * d")) # a b * c d * +
  print("\n",Shunt("a+b * c + d"))
