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

### Week 11 : 03/13/2018 ~ 03/22/2018

Q1. Descripe the operation of the lisp virtual machine. In what ways of these different to the operation provided by the java virtual machine?

Q2. Kotlin and Java are two languages, how are they similar and different?

Q3. How are containers same and different to the JVM? When would containers be most useful?

Q4. How are serverless apps are same and different to containers? When would serverless apps be most useful?

Q5. List and explain 3 advantages and 3 disadvantages of servesless apps.

Q6a. What is polymorphism?

Q6b. Assuming polymorphism, in the simulation of ducks and cows that "quack" and "moo", describle the centralized controllers and the duck and cow class. 

Q6c. The simulations have been extened, now there are humans that "sing", assuming polymorphism, what has to be changed in the centralized controllers?

In the following questions, assume there is a method call "ifTrue:ifFalse:". In polymorphic systems, control is pushed out to the leaf classes, here are the smalltalk definations of fTrue: and ifFalse:

	! Boolean methods !

	ifTrue: aBlock
		"inlined in the Compiler"
		^ self ifTrue: aBlock ifFalse: []

	ifFalse: aBlock
		"inlined in the Compiler"
		^ self ifTrue: [] ifFalse: aBlock

Q7. Assuming you have a random number generator, how would you code up "usually:" which two third of time act as "ifTrue:" ?

Here are some smalltalk code for iteration in an array, the method "value:value:" sends the values of each and (anotherCollection at: index) into aBlock,

	! In IndexableCollection methods ! 

	with: anotherCollection do: aBlock
		"Calls aBlock with every value from self
		and with indetically-indexed value from anotherCollection"

		self withIndexDo: [ :each :index |
			aBlock value: each value: (anotherCollection at: index) ]

Q8a. What might blocks be called in lisp?

Q8b. Write the with do methods in python, such that even numbered indexes of an array are printed.

Here are some smalltalk code for extracting or deleting items in a collection items

	! Collection methods !

	reject: aBlock
		^ self select: [ :each | (aBlock value: each) = false ]

	select: aBlock
		| stream |
		stream := self class new writeStream.
		self do: [ :each |
			(aBlock value: each) ifTrue: [
			stream nextPut: each ] ].
		^ stream contents

Q9. Write equivalent python iterators called "reject" and "select" such that reject is implemented as a special called selected. 

Covert the following kotlin code to python:

Q10a.
	when (x) {
    	1 -> print("x is 1")
    	2 -> print("x is 2")
    	3, 4 -> print("x is 3 or 4")
    	in 5..10 -> print("x is 5, 6, 7, 8, 9, or 10")
    	else -> print("x is out of range")
	}

Q10b.
	class Frame {
    	var width: Int = 800
    	var height: Int = 600

    	val pixels: Int
        	get() = width * height
	}

Q10c.
	val name = ship?.captain?.name ?: "unknown"

Q10d.
	str.removeSuffix(".txt")
	str.capitalize()
	str.substringAfterLast("/")
	str.replaceAfter(":", "classified")
