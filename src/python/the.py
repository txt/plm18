class o:
    def _(i): return i.__dict__
    def __init__(i, **d): i._().update(d)
    def __repr__(i):
        args = ['%s=%s' % (k, i._()[k]) for k in i._() if k[0] != "_"]
        return 'o(%s)' % ', '.join(args)

The = o(
  cards = o(hearts= "\u2665",
            clubs   = "\u2663",
            spades="\u2660",
            diamonds= "\u2666"),
  players = 2,
  interface = "scroll")

import re,traceback

PASS = FAIL = 0

def oks():
  global PASS, FAIL
  print("\n# PASS= %s FAIL= %s %%PASS = %s%%"  % (
         PASS, FAIL, int(round(PASS*100/(PASS+FAIL+0.001)))))

def ok(f):
  global PASS, FAIL
  try:
      print("\n-----| %s |-----------------------" % f.__name__)
      if f.__doc__:
        print("# "+ re.sub(r'\n[ \t]*',"\n# ",f.__doc__))
      f()
      print("# pass")
      PASS += 1
  except Exception as e:
      FAIL += 1
      print(traceback.format_exc())
  return f

class S:
  def __init__(i,txt): i.txt = txt
  def __eq__(i,prefix): return i.txt.startswith(prefix)

com="di"
print(S('discard') == com)

@ok
def _test1():
    assert 1==1,"ok"

@ok
def _test2():
    assert 1==2,"should be ok"

oks()
