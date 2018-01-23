
[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Project : Care for a Game of Cards?

## Goal 

In this subject you will implement a game using a domain-specific language implemented using Lopes' styles and Fowler's idioms.
If you need behavioral attachments, you can code them us as (e.g.) S-expressions interpreted by Norvig's LISP code or (e.g.)
some declarative and-or-not tree that queries a data base carried around as a working memory.

However you do it, your method for configuring the game must be <b><u><i>PERFECT</i></u></b>. A language of crystal clear clarity and beauty that anyone can glance at, understand, and code.

There is much in what follows that is under-specified. That is deliberate. Time to use your imagination.

## Task

Generating, prototyping, analyzing games in the space of ``what
can be played with a group of humans + 52 standard cards and nothing else''.

## Step0 (Feb7): Annotate two card games.

Note: this annotation will NOT be complete, Just a place to get you thinking.

- List what is similar, what is different. Write that down in English.  
- Two to four pages total. 
- Note no two teams can handle the same two games.
- Extra points if you have an abstract description of things that are true about both games, and specialty section where you describe the specific of each game.
- Things to think about:
    - What can a player do?
         - e.g. Play a card into a common space
    - How should the common space be structured? tree?
    - How to draw a card>
    - How to exchange a card, give or take from another player?
    - Hot to reveal information
    - How to bluff 
    - What are the win conditions? Lose/‚ÄùoutÄù conditions?
    - Starting states/deals/hands/piles
    - Turn structure -- ordered or turn less? Can it change during play?
    - How to make a game fun? Make it so that newbies don't die straight away, that 
      skills can be learned to make you play better? Make the game not too trivial to win or lose, but not too hard.
    - etc

# Step1 (Mar1): Executable annotations (V0.1)

- Make your English notes from step1 come alive
- There will be objects (players, cards)
- There will be states (desperation, caution)
- There will be iterators (for each turn do, for each player do,  for bad cards do...)
- There might be closures, S-expressions, state machines,
  compartments, and other cool things we learn later in this class.
- There will be functions (e.g. sorting cards; scoring hands). 
      - Are these global?
      - Are these parts of an object?
      - You decide... you are the designer!

## Step2 (Apr1): V1.0

- Using feedback from Mar1, deliver a better game
- Add an interface so that one human can jump into the game.

- Let the games begin. 
- We all play the game and each week we "vote off" half the games.

## Step3 (May1): Analysis

- Contrast the games that lived long or died early in April.
- What language features made them more or less fun?
- Pdf, 5-10 pages in [this format](https://www.acm.org/publications/proceedings-template-16dec2016)
