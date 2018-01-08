[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Syntactic Analysis

Before we begin, welcome to lexical analyzers and grammers. 

Standard pipeline

    tokenization ==> lexical analysis ==> parsing ==> code generation

Now after this pipeline there is a whole another process involved where we actually execute something.
And that means committing to the semantics of what we are processing. 
But that's a tale for another day. 

## Tokenization (fast, easy)

Kill whitespace, comments, etc ...

Returns an array of tokens.

Small example

Larger example [coco](http://satyr.github.io/coco/src/#lexer19)

## Lexical (fast, easy)

Lexical analysis: what kinds of words are in there?

- e.g. are you an operator (e.g. plus, minus, multiple) or an operand (1,2,"tim")
- e.g. if operand are you a number or a string or boolean or...?
- e.g. if operator are you a built-in (e.g. "while") or an extension (e.g. a method you've defined)
- e.g. if operator is it unary (1 argument), binary (2 args), n-ary (n args)
- e.g. if a "while" are you while, repeat-until, etc

Returns the token array, augmented with some extra information.

Small example.

Larger example: [coco](http://satyr.github.io/coco/src/#lexer)

- Questions:
   - What are the two kinds of "\\HURL"s in Coco?
   - Coco treats "\\unless" and "\\until" as synonyms for  something else. What?


## Parsing (not-so-fast, not-so-easy)

Here, you actually have to commit to what is, and is not, acceptable in your language.

Welcome to the wonderful world of grammaers.

Parsing = convert a sequence of linear tokens into a tree.

## Aside: Prolog

toknization, lexical analsis, parsing, all pretty much for free


### Precedence-driven Parsing

Fast, good for simple languages.



