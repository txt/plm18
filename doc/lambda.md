
[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Semantics: Lambda Bodies


By know you might think that program "semantics" means do whatver you
can to get things into a reverse polish
(e.g. using the ShuntingYard algorithm), then run that machine
using an RPN interpreter.

Not so. Turns out that the stack machine is but one of many "virtual machines"
used in programming. And stack machines are one of the least powerful.

For example, consider lambda bodies:

- [Paul Graham, origins of lisp](http://lib.store.yahoo.net/lib/paulgraham/jmc.ps)
       - Just read 1,2,3
- http://norvig.com/lispy.html
       - LISP in Python
       - Source code: https://github.com/norvig/pytudes/blob/master/py/lis.py
       - Note that in March, some part of lispy will be embedded into your code

