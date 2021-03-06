[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



### Attributed Grammars in Prolog

In _definite clauses grammars_ , or DCGs (a
subset of the Prolog logic programming language), the grammar is coded
as a patterns matches in a set of _clauses_ and terminals denoted
in _[squareBrackets]_.


     # the following clauses encode this grammar
	 #sentence
	 #    pronoun = [he] | [she]
     #	  verb_phrase
     #		   verb    = [likes]
	 #		   pronoun = [him] | [her]
			
     sentence         --> pronoun(subject), verb_phrase.
     verb_phrase      --> verb, pronoun(object).
     pronoun(subject) --> [he].
     pronoun(subject) --> [she].
     pronoun(object)  --> [him].
     pronoun(object)  --> [her].
     verb             --> [likes].

Note that in DCGs, if there are options, we just list multiple versions
of the same clause (e.g. there are four different  pronouns).

To do an attributed grammar in DCGs, we add extra
attributes to hold conclusions made while walking
some structure over the grammar. 

In the following
_Number_ is an attribute first found and set in the
_nounPhrase_ then used in the _verbPhrase_ (in Prolog,
anything that can be set starts in with an _UpperCaseLetter_
to _Number_ is set as we go down the tree).  

This _Number_ 
attribute ensure that the multiplicity of the
_nounPhrase_ agrees with the _verbPhrase_ (so if we
use a singular man for the noun, we use a singular
verb).

    #sentence
	#   nounPhrase
	#	   EITHER
	#		   determiner = [the]
	#		   noun       = [name] | [apple] | [men] | [apples]
	#	   OR 
	#	       pronoun    = [you]
	#   verbPhrase
	#	   EITHER
	#		   verb       = [eats] | [sings] | [men] | [applies]
	#	   OR 
	#	       verb       = as above
	#		   nounPhrase = as above

    sentence --> nounPhrase(Number), verbPhrase(Number).
    
    nounPhrase(Number) --> determiner, noun(Number).
    nounphrase(Number) --> pronoun(Number).
    
    verbPhrase(Number) --> verb(Number).
    verbPhrase(Number) --> verb(Number), nounPhrase(_).
    
    determiner --> [the].
    
    noun(singular) --> [man].
    noun(singular) --> [apple].
    noun(plural) --> [men].
    noun(plural) --> [apples].
    
    verb(singular) --> [eats].
    verb(singular) --> [sings].
    verb(plural) --> [eat].
    verb(plural) --> [sing].
    
    pronoun(plural) --> [you].

Note that this grammar demands that the number of verbs matches the number
of the nouns. A small variant to this grammar would break that rule:

    sentence --> nounPhrase(Number), verbPhrase(AnotherNumber).

Note that this new grammar could generate the sentence

     the,men,eats,the,apple]

while the original grammar would ensure that we always get

     the,men,eats,the,apples.

Object Grammars
---------------

Going one step further, the "Parse tree" is a nested set of objects. In
this design, each non-terminal is some instance of sub-class of
"Grammar". Once a language is parsed, an OO interpreter can execute the
parse tree, with each non-terminal handling the specific processing
associated with that node.

For example, an if-test would create and instance of class "If" with
slots for "expr" and then "then" and "else" actions.

      <if> => if <expr> then <action> else <action> fi

To interpret this, the OO interpreter just sends the message "evaluate"
to this instance which, in turn, sends "evaluate" to "expr". If that
returns true, then the "then" action is messaged with "evaluate". Else,
we "evaluate" the "else".

### OCAML

Pure function language. Functions define a relationship between input
types and output types.

A strongly typed language (at compile time, you know if a variable is a
string, number, whatever) and supported type inferencing (so you can
check if you are doing dumb things like adding a number to a string).

OCaml supports recursive type definitions. Question: is the following a
type system or a grammar or both?

      type paragraph =
          Normal of par_text
        | Pre of string * string option
        | Heading of int * par_text
        | Quote of paragraph list
        | Ulist of paragraph list * paragraph list list
        | Olist of paragraph list * paragraph list list
      
      and par_text = text list
      
      and text =
          Text of string
        | Emph of string
        | Bold of string
        | Struck of par_text
        | Code of string
        | Link of href
        | Anchor of string
        | Image of img_ref
      
      and href = { href_target : string; href_desc : string; }
      
      and img_ref = { img_src : string; img_alt : string; }

The Ulist and Olist constructors take the first item followed by a
(possible empty) list of items, to prevent empty lists --- this way,
there's at least one element.

So
[eigenclass.org](http://eigenclass.org/R2/writings/fast-extensible-simplified-markdown-in-ocaml)
uses the above to define a cool generator for HTML pages using a set of
short-cuts:

-   any character can be escaped with \\,
-   emphasis is done with \_\_ (less prone to accidental use than \_)
    and bold text with \*,
-   typographical abuses like bold emphasized text are not allowed,
-   headers are done with !level1 header, !!level2 header, etc.,
-   the \# character is thus free and can be used for numbered lists,
    replacing 1.,
-   pre-formatted code is done with


       {{
         whatever
       }}

It is possible to extend the markup with custom processors, using
    `{{extension-name` blocks; for instance, raw HTML is inserted with

    {{html
      <b> whatever </b>
    }}

(before you try to inject arbitrary HTML in the comments: this
    extension is only enabled in the main text).

The above grammar is the core of a parser that generates HTML. And,
interestingly, in this ultra-high level language, this parse runs very
very fast. <font size="2">

                                            runtimes                       memory
                                            -----------------------------  -------------
                                LoCs        README.1  README.8  README.32  README.32 MEM
      discount         C        ~4500                 0.016s    0.063s     2.8MB
      Bluecloth        Ruby     1100        0.130s    2.16s     30s        31MB
      markdown         Perl     1400        0.068s    0.66s     segfault   segfault
      python-markdown  Python   1900        0.090s    0.35s     2.06s      23MB
      Pandoc           Haskell   900 + 450  0.068s    0.55s     2.7s       25MB
      ----------------------------------------------------------------------------------
      Simple_markup    OCaml    313 + 55              0.012s    0.043s     3.5MB

</font>
So, in the 21st century, you can have you cake and eat it too:

-   High-level descriptions.
-   Tiny code.
-   Fast runtimes.

Excellent example of how pure theory improves implementations.

