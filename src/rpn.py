import sys
def hi(x):
  sys.stdout.write(x)

def rpn(input):
  minus    = lambda x,y : x - y
  plus     = lambda x,y : x + y
  mult     = lambda x,y : x * y
  args     = {"+" : plus, 
              "*" : mult, 
              "-" : minus}
  operator = lambda x: x in args
  stack    = []
  print('input = ', input)
  print('stack = ', stack)
  while input:
    token = input.pop(0)
    if not operator(token): # if operator, push token to stack
      stack += [token]
    else:
      two = stack.pop()     # if operator, pop next two stack items
      one = stack.pop()
      f= args[token]        # do something with them
      stack += [f(one,two)] # push to stack
    print('\ntoken = ',token)
    print('input = ', input)
    print('stack = ', stack)
  return stack[0]           # return first item in stack

def _shunt():
  print("5 + ((1 + 2) * 4) - 3 = " )
  print(rpn([5,1,2,"+",4,"*","+",3,"-"]))

_shunt()
