import yaml,re

class act:
  rules = []
  @staticmethod
  def when(s):
    def worker(fun):
      act.rules += [(s,fun)]
      return fun
    return worker

  @staticmethod
  def word(x):
    try: return int(x)
    except:
       try: return float(x)
       except: return x
  
  @staticmethod
  def asLambda( sentence ):
    for pat,fun in act.rules:
      m = re.match(pat,sentence)
      if m:
        return lambda: fun( *[act.word(x) 
                              for x in m.groups()])
    assert False, 'unknown [%s]' % sentence

  @staticmethod
  def prep(d):
    return {k:act.prep(v) if   isinstance(v,dict) 
                          else act.asLambda(v)
            for k,v in d.items()}

when=act.when

@when('from the (.+) try (.+)')
def start(where,repeats):
  print('starting at ',where,'for',repeats)

@when('hi (.+)')
def hi(x):
  print("hello",x)

@when('jump (.+) to (.+)')
def jump(here,there):
  print("jumping from",here,"to",there)

#-------------------------------
spec = """
  start: from the street try 3
  repeat:
    say: hi timm
    action: jump here to there
"""

x = act.prep( yaml.load(spec) )
x["repeat"]["action"]()
