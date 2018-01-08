[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Translate

## How to make it run

Old school: compile down to machine school

## Alternate Approach:  Don't "compile" (to machine code) but "translate" (

Transpiler: Source-to-source compiler

Much recent activity in the following.

- Target= LUA; e.g. Moonscript
- Target= Roll your own (e.g lis.py)
- Target= Java virtual machine (JVM): e.g. Scala, Clojure
- Target= JavaScript: e.g. ClojureScript, CoffeeScript
      - CoffeeScript is just JavaScript, plus 2000 lines of a grammar

## Not-Popular Alternatives

In theory,the following ould be used a lot. 

In practice, not so much. Why? Lets talk, after...

### Invert Control, then Use Polymorphism

Control structures are methods in leaf classes of the class hierarchy. 

- Trivial to add more control stuff

### Prolog

-  tokenization, grammar trees build right in, for free

### Macros

Mostly done for small stuff. But so people get so... ambitious

- m4 : text substutions (shudder, i love u but no one can understand  my m4 scripts)
     - BTW, early days of programming, "functions" were macros that expanded in-line within the calling function
     - Nasty. Variable name conflicts. Made recursion impossible (infinite expansion).
- LISP, Julia: macros actually have semantics. 

Literate, highly-readable, type annotated, imperative language that compiles to JavaScript. A customizable and extensible language with dynamic parser and meta language. MoonScript is a dynamic scripting language that compiles into Lua. The syntax of MoonScript has been heavily inspired by the syntax of CoffeeScript.
