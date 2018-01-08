Grammars
========

- Syntax
     -   the form or structure of the expressions, statements, and program units
-  Semantics: 
     - the meaning of the expressions, statements, and program units

Definitions

-   A "sentence" is a string of characters over some alphabet
-   A "language" is a set of sentences
-   A "lexeme" is the lowest level syntactic unit of a language (e.g.,
    \*, sum, begin)
-   A "token" is a category of lexemes (e.g., identifier)

Context-Free Grammars

-   Developed by Noam Chomsky in the mid-1950s
-   Language generators, meant to describe the syntax of natural
    languages Define a class of languages called context-free languages

Backus-Naur Form (1959)

-   Invented by John Backus to describe Algol 58
-   BNF is equivalent to context-free grammars

Example:

      <program> ==> <stmts>
        <stmts> ==> <stmt> | <stmt> ; <stmts>
         <stmt> ==> <var> = <expr>
         <var>  ==> a | b | c | d
         <expr> ==> <term> + <term> | <term> - <term>
         <term> ==> <var> | const

Example derivation:

      <program> => <stmts>  => <stmt> 
                            => <var> = <expr> 
                            => a = <expr> 
                            => a = <term> + <term>
                            => a = <var> + <term> 
                            => a = b + <term>
                            => a = b + cons

Or, consider, for example, the syntax of numeric constants accepted by a
simple hand-held calculator:

      <number>   => <integer> | <real>
      <integer>  => <digit> <digit> *
      <real>     => <integer> <exponent> | <decimal> ( <exponent> | Îµ )
      <decimal>  => <digit> * ( . <digit> | <digit> . ) <digit> *
      <exponent> => ( e | E ) ( + | - | Îµ ) <integer>
      <digit>    => 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

Parse tree
----------

A hierarchical representation of a derivation

                    <program>
                        |
                     <stmts>
                        |
                     <stmt>
                    /  |   \
                   /   |    \
                  /    |     \
              <var>   "="    <expr>
                |           /  |   \
              "a"     <term>  "+"   <term>
                        |             |
                      <var>         const
                        |
                       "b"

A grammar is "ambiguous" if and only if it generates a sentential form
that has two or more distinct parse trees

Example:

       <expr> ==> <expr> <op> <expr>  |  const
       <op>   ==> /  |  -

Two possible outputs:

                         <expr>                      <expr>
                        /   \   \                   /   |    \
                       /     \   \                 /    |     \
                <expr>     <op>  <expr>        <expr>  <op>   <expr>
                /  |   \       \      |          |      |    |  \   \
               /   |    \       |     |          |      |    |   \    \
              /    |     \      |     |          |      |    |    \     \
          <expr> <op>  <expr>   |     |          |      |   <expr> <op> <expr>
            |      |     |      |     |          |      |      |     |     |
          const   "-"   const   "/"  const     const   "-"   const  "/"   const

Fix: If we use the parse tree to indicate precedence levels of the
operators, we cannot have ambiguity

Example:

          <expr> ==> <expr> - <term>  |  <term>
          <term> ==> <term> / const| const

Output:

             <expr>
            /   |   \
       <expr>  "-"  <term>
          |         |  \  \
          |         |   \  \
          |         |    \  \
       <term>    <term> "/"  const
          |         |
       <const>   <const>


Operator associativity can also be indicated by a grammar


       <expr> ==> <expr> + <expr> |  const  (ambiguous)
       <expr> ==> <expr> + const  |  const  (unambiguous


Parse:

                                   <expr>
                                  /  |   \
                            <expr>  "+"   const
                          /   |   \    
                    <expr>   "+"   const 
                       |
                     const

Attributed Grammars
-------------------

Grammars generate all properly formed expressions in some language but
says nothing about their meaning. To tie these expressions to
mathematical concepts we need additional notation.

The most common is based on attributes. In our expression grammar, we
can associate a val attribute with each E, T, F, and const in the
grammar.

The intent is that for any symbol S, S.val will be the meaning, as an
arithmetic value, of the token string derived from S. We assume that the
val of a const is provided to us by the scanner.

We must then invent a set of rules for each production, to specify how
the vals of different symbols are related. The resulting *attribute
grammar* (AG) for a simple calculator is shown here:

![ag](http://unbox.org/open/trunk/310/14/spring/doc/img/ag.jpg)

### Attributed Grammars in Prolog

In _definite clauses grammars_ , or DCGs (a
subset of the Prolog logic programming language), the grammar is coded
as a patterns matches in a set of _clauses_ and terminals denoted
in _[squareBrackets]_.


     # the following cluases encode this grammar
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
attribute ensure that the mulitiplicity of the
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

These attributes can carry around numbers that we compute representing,
say, our belief in the current conclusions. In fuzzy logic we believe
conjunctions at the _minimum_ belief of each part and we believe
disjunctions at the _maximum_ belief of each part (and for negation,
we take the _complement_). For example here is a full Prolog version
of a fuzzy logic interpreter. Like DCGs, this is still a set of clauses
but now we are free to do more in each clause. Prolog denotes DCGs with a
_-->_ neck an full Prolog with a _:-_ neck.
        
    :- op(999,xfx,if).
    :- op(998,xfy,or).
    :- op(997,xfy,and).
    :- op(997,fy,not).
    
    student if young and poor and not dumb.
    
    dumb if not smart.
    
    cf(young,0.4).
    cf(poor,0.9).
    cf(smart,0.9).
    
    belief(X,Y) :- cf(X,Y).
    belief(X,Cf) :-
    	X if Z,
    	belief(Z,Cf).
    
    belief(X and Y,CF0) :-
    	belief(X,CF1),
    	belief(Y,CF2),
    	CF0 is min(CF1,CF2).
    
    belief(X or Y,CF0) :-
    	belief(X,CF1),
    	belief(Y,CF2),
    	CF0 is max(CF1,CF2).
    
    belief(not X,CF0) :-
    	belief(X,CF1),
    	CF0 is 1 - CF1.


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

From Parse Trees to Computation
-------------------------------

### Prolog DCGs

PROLOG is a logic programming language where programmers offer clauses
describing constraints between variables.

Those constraints can model recursive structures.

Computation = accumulating side-effects during that execution. e.g.

      ?- number(Value, [ two, hundred, and, twenty, three ], []). 

To which Prolog responds with:

      Value = 233

Program:

      number(0)    -->  [zero].
      number(N)    -->  digit(H), [hundred],
                        and_tens(T), {N is H * 100 + T}.
      number(N)    -->  sub_tens(N).
      
      and_tens(0)  --> [].
      and_tens(N)  --> [and], sub_tens(N).
      
      sub_tens(N)  --> digit(N).
      sub_tens(N)  --> teen(N).
      sub_tens(N)  --> tens(T), and_digit(D), {N is T + D}.
      
      and_digit(0) --> [].
      and_digit(N) --> digit(N).
      
      digit(1) --> [one].      teen(10) --> [ten].
      digit(2) --> [two].      teen(11) --> [eleven].
      digit(3) --> [three].    teen(12) --> [twelve].
      digit(4) --> [four].     teen(13) --> [thirteen].
      digit(5) --> [five].     teen(14) --> [fourteen].
      digit(6) --> [six].      teen(15) --> [fifteen].
      digit(7) --> [seven].    teen(16) --> [sixteen].
      digit(8) --> [eight].    teen(17) --> [seventeen].
      digit(9) --> [nine].     teen(18) --> [eighteen].
                               teen(19) --> [nineteen].
      
      tens(20) --> [twenty].
      tens(30) --> [thirty].
      tens(40) --> [forty].
      tens(50) --> [fifty].
      tens(60) --> [sixty].
      tens(70) --> [seventy].
      tens(80) --> [eighty].
      tens(90) --> [ninety].

Besides performing this syntactical analysis and calculating the value,
the program is also capable of providing an appropriate verbal
expression for a given value (synthesis).

      [user] ?- number(101, X, []). 
      
      X = [one,hundred,and,one]

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

