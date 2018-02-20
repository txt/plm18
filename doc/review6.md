[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Review

### Week 6 : 02/13/2018 ~ 02/15/2018

Q1. For the following code:

	switch id
    case \true \false \null \void \arguments \debugger then tag = \LITERAL
    case \new \do \typeof \delete                      then tag = \UNARY
    case \return \throw                                then tag = \HURL
    case \break  \continue                             then tag = \JUMP
    case \this \eval \super then return @token(\LITERAL id, true)length
    case \for
      id = []
      @fset \for true
      @fset \to false
    case \then
      @fset \for false
      @fset \to false
    case \catch \function then id = ''

	What kinds of "\UNARY" the coco has? What about "\LITERAL"?

Q2. For the following code:

    case \and \or \is
      @unline!
      if id is \is
      then @token \COMPARE \===
      else @token \LOGIC if id is \or then \|| else \&&
      @last.alias = true
      return id.length
    case \unless then tag = \IF
    case \until  then tag = \WHILE
    case \import
      if able @tokens then id = \<<<; break
      fallthrough
    case \export \const \var then tag = \DECL

	What is the difference between "\unless" and "\until" in coco?

Q3. What is BNF? Write a BNF that describing a car with body and engine, and body with 4 wheels.

Q4. Consider the following grammar

   <expr> ==> <expr> <op> <expr>  |  const
   <op>   ==> /  |  -
   
Q4a. What kind of sentance will it accept.

Q4b. Is this grammar ambiguous? Explain with an example.

Q5. Give an example of precedence-driven parsing, and describe its goal, input and output.

Q6. Give an example of legal and illegal parse tree, supported by xfx, fx, fy, yfx.
	
Q7. What is reverse polish notation?

Q7a. Convert 3 / (5 + y * x) into RPN.

Q7b. RPN interpreter has an input queue and a temporary stack. using the follwing example: 

	((1 + 2) * 4) - (3 + 1) * 8

	describle how rpn interperation works:

Q7c. The following has some errors, what are they and how could you fix them?

	5 + ((1 + 2) * 4) - 3 =
	input =  [5, 1, 2, '+', 4, '*', '+', 3, '-']
	stack =  []

	token =  5
	input =  [1, 2, '+', 4, '*', '+', 3, '-']
	stack =  [5]

	token =  1
	input =  [2, '+', 4, '*', '+', 3, '-']
	stack =  [5, 1]
	
	token =  2
	input =  ['+', 4, '*', '+', 3, '-']
	stack =  [5, 1, 2]

	token =  *
	input =  [4, '+', '+', 3, '-']
	stack =  [5, 3]

	token =  4
	input =  ['*', '+', 3, '-']
	stack =  [5, 3, 4]

	token =  *
	input =  ['+', 3, '-']
	stack =  [5, 7]

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

Q8. Convert 5 y + z x 3 - * / into in-fix.
	
Q9. What are the difference between pre-fix/in-fix/post-fix language? Give examples to explain.

Q10. Syntax diagrams and BNF grammars have equivalent power: whatever languages you can describe with one, you can describe with the other. Is that true or false?

Q11. Interpret the rules of shunting.

Q12. Describle how shunting yard algorithm works for the following infix notations:

	4 + 18/(9 - 3)
	
Q13. The following has some errors, what are they and how would you fix them?

    A * B ^ C + D  =

      Current Symbol     Operator Stack    Postfix String
    1      A                                    A
    2      *                  *                 A
    3      B                  *                 A B
    4      ^                  ^ *               A B
    5      C                  ^ *               A B C
    6      +                  +                 A B C * ^
    7      D                  +                 A B C * ^ D
    8                                           A B C * ^ + D
