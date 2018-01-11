[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Syntactic Analysis



Standard approach

1. The lexical phase (scanner) groups characters into lexical units or
  tokens. The input to the lexical phase is a character stream. The
  output is a stream of tokens. Regular expressions are used to define
  the tokens recognized by a scanner (or lexical analyzer). The
  scanner is implemented as a finite state machine.
2. The parser groups tokens into syntactical units. The output of the
  parser is a parse tree representation of the program.  Context-free
  grammars are used to define the program structure recognized by a
  parser. The parser is implemented as a push-down automata.
3. The contextual analysis phase analyzes the parse tree for
  context-sensitive information often called the static semantics. The
  output of the contextual analysis phase is an annotated parse
  tree. Attribute grammars are used to describe the static semantics
  of a program.
4. The optimizer applies semantics preserving transformation to the
  annotated parse tree to simplify the structure of the tree and to
  facilitate the generation of more efficient code.
5. The code generator transforms the simplified annotated parse tree
  into object code using rules which denote the semantics of the
  source language.
6. The peep-hole optimizer examines the object code, a few instructions
  at a time, and attempts to do machine dependent code improvements.## Commit to some Semantics

Standard pipeline

    tokenization ==> lexical analysis ==> parsing ==> (a) ==> code generation ==> (b)

Note that before code generation they may also be

    (a) = context anaysis ==> optimizer 

And after code generation 

    (b) = peephole optimization

This talk: 

- Syntax: everything up to and including parsing

Next talk:

- Semantics: the rest.


## Tokenization (fast, easy)

Group input stream (of characters) into a stream of
tokens (lexeme) and constructs a symbol table which is used later for
contextual analysis. The lexemes include

+ Kill whitespace, comments, etc ...
+ Key words,
+ identifiers,
+ operators,
+ constants: numeric, character, special, and Witem comments.

Returns an array of tokens.

### Small example (cheating, a little)

This one is a hack. A beautiful hack. But a hack never the less.

_From http://norvig.com/lispy.html_

Running:

    >> program = "(begin (define r 10) (* pi (* r r)))"
    
    >>> parse(program)
    ['begin', ['define', 'r', 10], ['*', 'pi', ['*', 'r', 'r']]]

Code:    

```python
Symbol = str          # A Lisp Symbol is implemented as a Python str
List   = list         # A Lisp List is implemented as a Python list
Number = (int, float) # A Lisp Number is implemented as a Python int or float


def parse(program):
    "Read a Scheme expression from a string."
    return read_from_tokens(tokenize(program))

def tokenize(s):
    "Severely cheating. Convert a string into a list of tokens."
    return s.replace('(',' ( ').replace(')',' ) ').split()

def read_from_tokens(tokens):
    "Read an expression from a sequence of tokens."
    if len(tokens) == 0:
        raise SyntaxError('unexpected EOF while reading')
    token = tokens.pop(0)
    if '(' == token:
        L = []
        while tokens[0] != ')':
            L.append(read_from_tokens(tokens))
        tokens.pop(0) # pop off ')'
        return L
    elif ')' == token:
        raise SyntaxError('unexpected )')
    else:
        return atom(token)

def atom(token):
    "Numbers become numbers; every other token is a symbol."
    try: return int(token)
    except ValueError:
        try: return float(token)
        except ValueError:
            return Symbol(token)
```

### Large Example

Using a more scalable, less hacky tool (Flex).


INPUT:


      abc123z.!&*2ghj6


ANALYZER (in Flex)


        /*** Definition section ***/
        
        %{
        /* C code to be copied verbatim */
        #include <stdio.h>
        %}
        
        /* This tells flex to read only one input file */
        %option noyywrap
        
        %%
            /*** Rules section ***/
        
            /* [0-9]+ matches a string of one or more digits */
        [0-9]+  {
                    /* yytext is a string containing the matched text. */
                    printf("Saw an integer: %s\n", yytext);
                }
        
        .       {   /* Ignore all other characters. */   }
        
        %%
        /*** C Code section ***/
        
        int main(void)
        {
            /* Call the lexer, then quit. */
            yylex();
            return 0;
        }


OUTPUT:

       Saw an integer: 123
       Saw an integer: 2
       Saw an integer: 6

### Even  larger example 

[coco](http://satyr.github.io/coco/src/#lexer19)

## Lexical (fast, easy)

Lexical analysis: what kinds of words are in there?

- e.g. are you an operator (e.g. plus, minus, multiple) or an operand (1,2,"tim")
- e.g. if operand are you a number or a string or boolean or...?
- e.g. if operator are you a built-in (e.g. "while") or an extension (e.g. a method you've defined)
- e.g. if operator is it unary (1 argument), binary (2 args), n-ary (n args)
- e.g. if a "while" are you while, repeat-until, etc

Returns the token array, augmented with some extra information.

### Small example:

```prolog
sentence(s(NP,VP))               --> noun_phrase(NP,Num), verb_phrase(VP,Num).

noun_phrase(np(DET, NP2), Num)   --> determiner(DET, Num), noun_phrase2(NP2, Num).
noun_phrase(np(NP2), Num)        --> noun_phrase2(NP2, Num).
noun_phrase2(np2(N), Num)        --> noun(N, Num).
noun_phrase2(np2(ADJ, NP2), Num) --> adjective(ADJ), noun_phrase2(NP2, Num).

verb_phrase(vp(V), Num)          --> verb(V, Num).  
verb_phrase(vp(V, NP), Num)      --> verb(V, Num), noun_phrase(NP, _).

determiner(det(the), _)      --> [the].
determiner(det(a), singular) --> [a].

noun(n(pumpkin), singular)   --> [pumpkin].
noun(n(pumpkins), plural)    --> [pumpkins].
noun(n(lecturer), singular)  --> [lecturer].
noun(n(lecturers), plural)   --> [lecturers].

adjective(adj(possessed))    --> [possessed].

verb(v(scares), singular)    --> [scares].
verb(v(scare), plural)       --> [scare].
```
Example:

     [the,pumpkin,scares,the,lecturer] ==>
     s(np(det(the),np2(n(pumpkin))),vp(v(scares),np(det(the),np2(n(lecturer)))))

### Larger example: [coco](http://satyr.github.io/coco/src/#lexer)

- Questions:
   - What are the two kinds of "\\HURL"s in Coco?
   - Coco treats "\\unless" and "\\until" as synonyms for  something else. What?


## Parsing (not-so-fast, not-so-easy)

Here, you actually have to commit to what is, and is not, acceptable in your language.

Welcome to the wonderful world of grammaers.

Parsing = convert a sequence of linear tokens into a tree.

A parser groups tokens into syntactical units. The output of the
parser is a parse tree representation of the program.
Grammars are used to define the program structure recognized by a
parser. 

Yacc and Bison are tools for generating parsers in C. Bison
is a faster version of Yacc. Jack is a tool for generating scanners
and top-down parsers in Java.

### Precedence-driven Parsing

Fast, good for simple languages via the shunting yard algorithm.

Background: reverse Polish notation

- Operands appear before operators
- Not 3 + 4
    - But 3 4 +
- Not 3 − 4 + 5
    - But 3 4 − 5 +

Crazy simple to execute

1. Input is a list we process left to right
2. Internally, we keep a stack for temp results
3. Pop next left-most item from input
4. If operand, push to temp stack
5. If binary operator, pop next two items from temp stack, combine, push result to stack
6. If  input empty, return first item in temp stack

```python
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
```

Example:

```
$ python3 rpn.py
5 + ((1 + 2) * 4) - 3 =

token =  5
input =  [1, 2, '+', 4, '*', '+', 3, '-']
stack =  [5]

token =  1
input =  [2, '+', 4, '*', '+', 3, '-']
stack =  [5, 1]

token =  2
input =  ['+', 4, '*', '+', 3, '-']
5 + ((1 + 2) * 4) - 3 =
input =  [5, 1, 2, '+', 4, '*', '+', 3, '-']
stack =  []

token =  5
input =  [1, 2, '+', 4, '*', '+', 3, '-']
stack =  [5]

token =  1
input =  [2, '+', 4, '*', '+', 3, '-']
stack =  [5, 1]

stack =  [5, 1, 2]

token =  +
input =  [4, '*', '+', 3, '-']
stack =  [5, 3]

token =  4
input =  ['*', '+', 3, '-']
stack =  [5, 3, 4]

token =  *
input =  ['+', 3, '-']
stack =  [5, 12]

token =  +
input =  [3, '-']
stack =  [17]

token =  3
input =  ['-']
stack =  [17, 3]

token =  -
input =  []
stack =  [14]
14
```

### Aside: Prolog

Tokenization, lexical analsis, attributed-grammers,
precendence-driven parsing, all pretty much for free

Example:
Lets carry around numbers that we compute representing,
say, our belief in the current conclusions. In fuzzy logic we believe
conjunctions at the _minimum_ belief of each part and we believe
disjunctions at the _maximum_ belief of each part (and for negation,
we take the _complement_). For example here is a full Prolog version
of a fuzzy logic interpreter. Like DCGs, this is still a set of clauses
but now we are free to do more in each clause. Prolog denotes DCGs with a
_-->_ neck an full Prolog with a _:-_ neck.
        
    :- op(999,xfx,if).
    :- op(998,xfy,or).
    :- op(997,xfy,and).
    :- op(997,fy,not).
    
    student if young and poor and not dumb.
    
    dumb if not smart.
    
    cf(young,0.4).
    cf(poor,0.9).
    cf(smart,0.9).
    
    belief(X,Y) :- cf(X,Y).
    belief(X,Cf) :-
    	X if Z,
    	belief(Z,Cf).
    
    belief(X and Y,CF0) :-
    	belief(X,CF1),
    	belief(Y,CF2),
    	CF0 is min(CF1,CF2).
    
    belief(X or Y,CF0) :-
    	belief(X,CF1),
    	belief(Y,CF2),
    	CF0 is max(CF1,CF2).
    
    belief(not X,CF0) :-
    	belief(X,CF1),
    	CF0 is 1 - CF1.

