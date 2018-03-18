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

