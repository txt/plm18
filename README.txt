# Ideas

Systems
- travis integration
- mysql integration
- find standard libraries. implement them
   - mustache
   - markdown
   - xml library
   - json library
   - stats
   - collections
   - the jamie 17
       https://github.com/jamiejennings/rosie-pattern-language/blob/tranche-2/src/core/list.lua
       Tests/examples are in:
       https://github.com/jamiejennings/rosie-pattern-language/blob/tranche-2/src/list-test.lua
- modes for vim, emacs, and what ever else is in the
  language dejour
        - time to struggle with viml, elisp, etc
	- what should a mode do?
        - long string highlighting
	- markdown highting within a string
	- lints. what lints?
	- reformat (to arnold's standards)

Port little languages

- miniKaren
- Norvig's lisp

closures (is that even possible?)

Add an OO layer

polymorphism
- static: if the LAST thing in "." chain is a ( then
  at load time, do the lookup  (assumes that all files
  have "safe" BEGIN statements and that methods defined
  before used; e.g. superclassed before sub-classes
  )
- dynamic: ?
- add "function Num.fred" notation

anyway to garbage collect instance memory ?
- if not, what is the cost? (dude, we are not writing operating
  systems here). ? a linit for local vars that are objects?

not multiple inheritance

```
BEGIN { 
  OK.instances.id=0
}
function isa(class1,class2) {
  OK.instances.exists[class1]
  OK.instances.exists[class2]
  OK.instances.parent[class2] = class1
}
function new(i,class,   id,tmp) {
  if (class=='') class='lobby'
  ++OK.instances.exists[class]
  id = class ++OK.instances.exists[class]
  OK.instances.isa[id] = class
  return id
}
function call(i,what,a,b,c,d,e,f,g,h,i,j,k,l,m) {
  class = OK.instances.isa[i] 
  return call1(OK.instances.is[i],what,
                 a,b,c,d,e,f,g,h,i,j,k,l,m)
}
function call1(class,i,what,a,b,c,d,e,f,g,h,i,j,k,l,m) {
  if (class=="") "class-less instance"/0
  if (what in OK.instances[class].does)
     return funcall(i,OK.instances[i].does,
                    a,b,c,d,e,f,g,h,i,j,k,l,m)
  else if (class in OK.instances.parent) {
     return call1(OK.instances.parent[class],
                  i,what,
                  a,b,c,d,e,f,g,h,i,j,k,l,m)
  else "method lookup failure"/0   
}
```
