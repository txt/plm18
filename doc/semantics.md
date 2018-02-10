[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______


# Semantic Analysis



i- re- Stack machines

Compile to those semantics

Examples:

Turing's machine

von-Neumann Machines
stacks (forth)

Data-flow machines

Resolution

Lambda Calculus
yzers and grammers. 

Objecs and mesages

Production rules

pattern-based: pipeline, MVC, blackboard

Here, you actually make the code work.

To begin with:

consider the following old joke:

+ An older fish swims past two younger ones and asks "How's the water?".
+ The younger ones reply: "What's water?"

That is, the inexperienced fish could not see
the structures that were all around them, and which
they use every day.

<center>
<img src="http://unbox.org/open/trunk/310/14/spring/doc/img/fishtank.png" width=300>
</center>

This subject will say programmers are mostly unaware
that that their programs (they use every day) are surrounded by structures.
_And that this is deliberate_ since the point of programming languages is
to write programs and _programs are things that make maths palatable_.

So every programmer is a mathematician (they just do need to know that).
But every programming language _designer_ needs to understand that maths
since it is that maths that defines what is (im)possible in that language.
  
Don't believe it? Well consider this:

+ Anytime you search for a string, you are probably using 
   [regular expressions](http://goo.gl/KASraS), which is a little language that
    specifies finite state machines.
+ Every time anyone tests a program, they usually doodle a finite state
  machine to clarify the intent of the program.
+ Every time anyone compiles a program, they are using type theory
  to explore the range of operations available for the program types.
+ Every time you pass a variable to a procedure/method/function,
  you are using something like
  Alfonzo Church's [lambda calculus](http://en.wikipedia.org/wiki/Lambda_calculus)
  to ensure that all things that use
  that variable access the right contents. 
+ When the first computers were built in the USA, they were written
  by engineers who literally pulled about the book on some
  uber maths called the [Turing machine](http://en.wikipedia.org/wiki/Turing_machine).
  And the Turing machine was created by Church's Ph.D. student, Alan Turing.
  + Any functional programmer uses McCarthy's 1960 memo on
  [Recursive Functions of Symbolic Expressions](http://www-formal.stanford.edu/jmc/recursive/recursive.html) 
  (which is slightly easier to read in 
  [Paul Graham's version](http://lib.store.yahoo.net/lib/paulgraham/jmc.ps) 
  or in [Peter Norvig's lispy code](http://norvig.com/lispy.html). 
+ Logic programmers literally program in mathematical logic.
+ If you use the _make_ tool, it find the _dependencies_ in your files
  and can run one parallel computation for each separate set.

So every program has maths below it, buried under a layer of syntactic sugar:

<center>
<img src="http://unbox.org/open/trunk/310/14/spring/doc/img/language.png" width=600 align=center>
</center>

The syntactic sugar of a program
consists of all the stuff that makes
the language usable:

+ Simplifications of complex processing;
+ Short-cuts to quickly code common idioms (e.g. macros,
  commonly-used control structures, class or function libraries for
  patterns or idioms);
+ Watch dogs that raise alerts if you do something
  wrong.
 
(By the way- its not _just_ syntactic sugar since
some "sugar" actual enables the clear expression of
ideas that would otherwise be too long to write down
or [too slow to run](http://unbox.org/open/trunk/310/14/spring/doc/96koller.html). Also, the watch dogs
can only report problems if they know
what a problem is- which means they
have to understand the purpose and limits of
the underlying maths.)

The maths defines what can be done, and what cannot
be done in that language. Such maths includes:

+ Closures
+ Dependencies
+ Logic
+ The predicates of logic programming
+ Functions
+ Objects
+ State machines
+ Etc

And underneath that maths is another layer of uber maths
([Turing machine](http://en.wikipedia.org/wiki/Turing_machine))
 that defines the ultimate limits of all the above. 

## Method1 (very popular right now): Transpile

- Don't do semantic analysuis. Translate code (source to source translation) and let the target language work it out.

So how do you deal with the semantics?

## Method1: Ignnore it

Use a procedural approach. Transpile and just run your source language1 using the stuff you understand in the targer language2.
