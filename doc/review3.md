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

### Week 3 : 01/23/2018 ~ 01/25/2018

## Syntactic/Semantic Analysis

Q1. Describe what is the role of finite state machine in syntactic analysis? 

Q2. What is static semantics?

Q3. Give some examples about lexemes in Tokenization.

Q4. What kind of information does Lexical analysis return?

Q5. What does parser and grammer do in parsing?

Q6. Give the defination of the following terms in parsing:

	-sentence  -language  -lexeme  -token

Q7. In state machines, what visual icon represents the final state?

Q8. In state machines, what are do edges mean?

Q9. In state machines, what are gaurds?

Q10. What is the difference between__main__.py and __init__.py ?

Q11. For this code, how many elements does y have?

    y = [x/2 for x in range(0,100) if x > 60]


Q12. Consider the following  "ordered" function do? What happened if the 2nd paramter is missing?

    def ordered(lst,key=me):
      lst.sort(key=key)
      return lst
	  
Q13. For the following code, what does 'what(pair)' function do?

    def what(pair):  return pair[1]

Q14. For the following code:

    def score(pair): return pair[0]
    def unscore(pair): return -1*score(pair)
    def what(pair):  return pair[1]	

What is the output?

	#14a
	print( ordered([ [3, "dog"],[4,"cat"],[1,"dog"]], key=unscore))
  
	#14b
	print( ordered([ [3, "dog"],[4,"cat"],[1,"dog"]], key=what))
  
	#14c
	print( ordered([k for k in d.keys()], key=score))

	
Q15. In the following  if I want to change the 5th element's value to 5 in "old" list, then print it on the last line, what should I do?

    def eg1():
      old=[10,20,30,40, 50,60,70]
      old[0] = 100
      old[-1]= "rd"
      print(old[2:])
      new=old[:]
      # needs more stuff here
  
  
Q16. In "eg1", what does 'old[-1]= "rd"' do?

Q17. In "eg1", what does 'print(old[2:])' do?

Q18. If I want the "new" list gets the same elements as "old" except the first element, what should I do?

Q19. If I want the "new" list gets the same elements as "old" except last element, what should I do?

Q20. What does the final "old" list look like?

Answer:
https://goo.gl/7inPCA
