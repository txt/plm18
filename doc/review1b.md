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

### Week 1 : 01/09/2018 ~ 01/11/2018

## DSL

Q1: What is the differenete between a domains speciifc language and a general language?

Q2: Give one example of a domain specific language. When would you use it? And when would you not use it?

Q3: Give one example of a general language. When would you use it? And when would you not use it?

Q4: Give the language fregment

	x*2 +     
	y/3.14  # this is a little example


Q5: How might this frament tokenize? What meta knowledge might be collected on each item?

Q6: How might this fragment parse?

Q7: What is tokenization?

Q8: What is parsing?

Given the following regular expression 

	A+B+
     
Q9: What could it match?

Q10: What if something it would not match?

Q11: Underneath regular expression, what is mathematic model?

Q12: What is Hersleb hypothesis? If you are a software manager, how could you apply the hersleb hypothesis?


## Pipes

Pipes are used to connect together lots of little utiliies. 

Q13: What does this pipe do? What are its parts?

      ls | grep '/^[a-z]/' | wc -l

In shell scipt, pipes only connect one input to one output.

Q14: Comment: pipes are stupid cause they are too simple.

Q15: Comment: pipes are fantastic cause they are so simple.

## AWK

AWK is a pattern matching language:

- consisting of pattern-action pairs
- and function
- Variables are usually global and auto-initialize (usually to `""` or `0`).
- where lines of input are divided into fields $1, $2,.... up to the number of fields `NF` 
- `$i` means "item in field i". 
- $0 denotes the whole line (and updating $i also updates $0).
- Arrays can have keys that are numbers or strings.
- `NR` is the record number; i.e. line number

Q16: In the following, which is the pattern/action? What does this code do?

      NF > 3 { print $0 }

Q17: What is the default action? What does the following do?

      1 

Q18: What is the default pattern? Guess does the following awk program do?

      { print length($0), $0 } 

(THIS PARA IS **NOT** EXAMINABLE.)
A Bayes classifier keeps counts on what symbols are seen for different classes. 
It can compute the probability that new items belong to a class `H` using evidence `E` using:

     P( H|E ) = P( E|H ) * P(H) / P(E) 

Suppose data is represented as a comma-seperated file and the class is in the last column. Example, this file is about whether or not we played golf
    
```
outlook	 temp,	humidity, windy,play
sunny,	 hot,	high,	FALSE,	no
sunny,	 hot,	high,	TRUE,	no
overcast,hot,	high,	FALSE,	yes
rainy,	 mild,	high,	FALSE,	yes
rainy,	 cool,	normal,	FALSE,	yes
rainy,	 cool,	normal,	TRUE,	no
overcast,cool,	normal,	TRUE,	yes
sunny,	 mild,	high,	FALSE,	no
sunny,	 cool,	normal,	FALSE,	yes
rainy,	 mild,	normal,	FALSE,	yes
sunny,	 mild,	normal,	TRUE,	yes
overcast,mild,	high,	TRUE,	yes
overcast,hot,	normal,	FALSE,	yes
rainy,	 mild,	high,	TRUE,	no
```

In the following code `data[a][b][c]++` increments the count of items in  a nested array (default value =0).
Note that `data` is part of the `P(E|H)` term in the above equation.


Q19:  What is found in `$NF` on each line?

Q20: Why is there no gaurd for the second  `gsub` action?

Q21: For what kind of rows is `data` NOT updated?

```awk
            # tell awk that fields are seperated by a comma
      BEGIN { FS="," }

            # kill white space
            { gsub(/[ \t]*/,"") # replaces any space and tabs with nothing
              if ($0=="")       # if nothing left, go to next line
	            next }
      
            # read column names in line 1
      NR==1 { for(i=1; i<=NF; i++) { 
                name[$i] = i      # index from column name to column num
                col[i]   = $i  }} # index from column num  to column name
      
            # store data
      NR >1 { for(i=1; i<=NF; i++)
                data[ $NF ][ col[i] ][ $i ]++ }
    
      # mystery function: what does it do?
      # HINT: `a[ length(a) ]`  returns the last item in array `a`.
      function xxx(h) { return data[h][ col[ length(col) ] ][h] / NR }
```

Q22:  For the above table of data about golf data, what would be found in    
  `name[ "outlook" ]`.

Q23: For the above table of golf data, what would be found in     
  `data[ "yes" ][ "outlook" ][ "sunny" ]` ?

Q24: (HARD) What does the following call return? So what is a better name than `xxx`?    
  `END {print  xxx("yes") }`




