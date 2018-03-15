
[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______

# Project3 : Essence + Details

## Admin

Due April13.

What to hand in 

- Pointer to github repo whose top level contains a directory `proj3`.
- The directory contains `proj3.pdf` (the above report), the final code, and 2 examples that the whole thing works (the games in action).
   - Video
   - or text transcript


### Introduction

_For any particular thing, ask What is it in itself? What is its nature?_    
-- [Marcus Aurelius](https://www.youtube.com/watch?v=f33ieCWRWlI)

_There's what you want to say it. There's how you have to write it. In between, there's a gap._   
--Tim Menzies

These are the domain specific language questions:

- How much of a program is a specification? 
- How much are details needed to make the spec run? 
- How can we minimize the typing required to change that spec? 
- How can we make the spec obvious, seperating it from the details?
- How can we hide the tedious detail, thus enabling a wider audience of people to use that code?
- If we want the users to code the logic, how succinctly can we express that logic?

Your task is to:

1. Take game1.
2. Find and list common programming patterns in game1.
3. Seperate those patterns into essence and details
4. Define a notation for the essence
5. Build the underlying machine to handle the details
6. Demonstrate that this new game1 runs.
7. Take game2 Repeat steps 2,3,4,5,6.
8. Write a report that
      - Describes steps 4,5 for each game
      - Reflect on step7. Specifically, how much of the game1 mechanisms had to be modified to handle game2
      - Reflect on what code could NOT be seperated and implemented as per stesps 2,3,4,5. Why was that so? What would be needed to make it so?

Pragmatics:

- In reality, you'll only be able to conver X% of your proj1 code into essence + details. 
- Strive for large X. 
- Acknowledge that it may not be so large.


How:

- Add in different programming paragims
      - object-shorthand, Lambda, state machines, and some other tricks we'll get too soon (compartmental models, logic programming)

### Example0 (very simple)

Simple interactor for generting random numerbs form a distribution.

- Allows for a tiny short hand in the rest of the code.

Generate often seen things most often
while generating rarer this more rarely.
Given a dictionary d{k1=n1, k2=n2, ...},
  return enough keys ki at probability

      pi = ni/n where n = n1+n2+..

e.g.

     for key in some({'box':30,'circle':20,'line':10},20)
         print key

This will return around twice as many boxes as anything else,
  circles 1/3rd of the time and lines 1/6th of the time.

```python
def often(d,enough=10**32):
  n, lst = 0, []
  for x in d:
    n   += d[x]
    lst += [(d[x],x)]
  lst = sorted(lst, reverse=True)
  while enough > 0:
    r = random.random()
    for freq,thing in lst:
      r -= freq*1.0/n
      if r <= 0:
        yield thing
        enough -= 1
        break

def oftenExample():
  random.seed(1)
  return [['box','line',  'circle','box','box',
           'box','circle','circle','box','box'],
          [x for x in
           often({'box':30,'circle':20,'line':10},
                 10)]]
```

### Example1: State Mahines

- Consider the [FSM code](https://github.com/timm/sandbox/blob/master/machines.py#L163-L175)
      - Called using `python3 machines.py 1`
- Think of all the machinery under-the-hood that lets us write something that brief: several objects, numerous convenience functions, etc, etc.
- But I think that syntax is ugly, superflous, Mostly removable.

### Example2:

- Now consider the [more succinct FSM code](https://github.com/timm/sandbox/blob/master/machines.py#L177-L184)
- See how the code is called with several ``convenience tools' `m,s,t` passed in.
- See how the state machine is createmed
     - `Machine2` calls `make`, passing `spec001` which is a lambda body that knows the transistions
     - `Make` calls `spec001`, passing `spec001` as well as machine state and transistion creators
- Note how obvious repeated tasks have been buried away. 
     - eg. in `t`, if an state name alrady exists then we just return it. See [Machine.state](https://github.com/timm/sandbox/blob/master/machines.py#L131-L134)
     - eg the start state is the first state ever mentioned see https://github.com/timm/sandbox/blob/master/machines.py#L133

### Example3: Compartmental models

- [Compartmental models](https://github.com/txt/ase16/blob/master/doc/dsl.md#example-diapers)
      - We will go over this one in class.
- For know, note that the high level spec is just a simple subclass of `Model` containing a story of how babies
  fill diapers:

```
 q   +-----+  r  +-----+
---->|  C  |---->|  D  |--> s
 ^   +-----+     +-+---+
 |                 |
 +-----------------+

C = stock of clean diapers
D = stock of dirty diapers
q = inflow of clean diapers
r = flow of clean diapers to dirty diapers
s = out-flow of dirty diapers
```

This is modeled as one `have` methods that initializes:

+ `C,D` as a `Stock` with initial levels 100,0;
+ `q,r,s` as a `Flow` with initial rates of 0,8,0

and as a `step` method that  takes state `u`
and computes a new state `v` at
time `t+dt`.


```python
class Diapers(Model):

  def have(i):
    "create the model"
    return o(C = S(100), D = S(0),
             q = F(0),  r = F(8), s = F(0))

  def step(i,dt,t,u,v):
    "update new payload `v` using old payload `u`"
    def saturday(x): return int(x) % 7 == 6
    v.C +=  dt*(u.q - u.r)
    v.D +=  dt*(u.r - u.s)
    v.q  =  70  if saturday(t) else 0
    v.s  =  u.D if saturday(t) else 0
    if t == 27: # special case (the day i forget)
      v.s = 0
```

### Example4,5,6,7,8...


Of course there are many more ways to reason about the world. Many more abstractions

Have at it!

