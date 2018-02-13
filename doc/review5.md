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

### Week 4 : 02/06/2018 ~ 02/08/2018

Q1. What is python exception class?

Q2. How does "try-except" statement work?

Q3. How to create and use a user-defined error exception class?

Q4. Give some examples about python built-in exceptions.

Q5. How to force a specified exception to occur in python?

For the following function, answer Q6:

	def print_list_element(alist, index):
		print(alist[index])

Q6. Add a try-except statement to the body which handles a possible IndexError, which could occur if the index provided exceeds the length of the list. Print an error message if this happens.

Q7. Give a simple example about calling a nested function in Python.

Q8. Given a string "apple", how to get a list as ['a', 'p', 'p', 'l', 'e', 'apple']?

Q9. Give a simple ternary operator example and explain how does it work?

Q10. Create a simple function with iteration in python then convert it to recursive function.
	
In homework 3, for the following functions, answer Q11.

	class o(Thing):
		def __init__(i, **dic): 
			i.__dict__.update(dic)
		def __getitem__(i, x): 
			return i.__dict__[x]

Q11A. Give an example of python magic methods.

Q11B. Give an example of creating an instance of this class to store name = "patrick", age = "24".

Q11C. Using the instance created in 11B, how to access "patrick"?

Q11D. What is ```__dict__```?

Q12. Explain the list comprehension

Q13. What does the following function do?

    def kv(d):
    	return '(' + ', '.join(['%s: %s' % (k, d[k]) for k in sorted(d.keys()) if k[0] != "_"]) + ')'
