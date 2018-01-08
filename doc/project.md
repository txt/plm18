
______

# The Game: Puppy Power (in Python)!

## Goal 

In this subject you will implement a game using a domain-specific language implemented using Lopes' styles and Fowler's idioms.
If you need behavioral attachments, you can code them us as (e.g.) S-expressions interpreted by Norvig's LISP code or (e.g.)
some declarative and-or-not tree that queries a data base carried around as a working memory.

However you do it, your method for configuring the game must be perfect. A language of crystal clear clarity that anyone can glance at, understand, and code.

### Background 

<img align=right src="http://www.petsworld.in/blog/wp-content/uploads/2014/09/running-cute-puppies.jpg">

Welcome to PuppyLand where all the machines are powered by puppy cuteness. Power shortages are chronic so teams are sent out to
search the world looking for more puppies.


Puppies are fixed in number  at the start of the game.
Some countries have lots of puppies, some have none. The occurrence of puppy-less countries is spread
out evenly across the world.


You will code a team of 4  walking the earth looking for puppies, which you will collect and return to PuppyLand.
Once you get home, you can go out again to get more.

Points increase the faster more of your team bring home more puppies.
Points decrease if (say), only one of you gets back, empty handed, after a very long time.

### Team Members

As you walk the world, you leave behind footprints that never wash off. And the more people that walked some
spot, the deeper the footprints.
This means you can execute a 
[tabu search](https://en.wikipedia.org/wiki/Tabu_search#Pseudocode) or 
[ant colony optimization](https://en.wikipedia.org/wiki/Ant_colony_optimization_algorithms#Example_pseudo-code_and_formula)
to get more puppies home faster.

Walking requires food (apples). Sometimes you come across apples which if you eat, you can walk further.
Such apples grow X% per time T, spontaneously in all the lowland countries.
Any apple bigger than 1 can be eaten. You can eat any whole number of that apple (and the rest remains for others).
If you run out of food, you are stuck; i.e.
you must sit still hoping another member of your team will find you and give you apples. You can live forever stuck.

### Hollering

Any member of the team
can holler at strength 1 2 3 4 in which case, for as long as you holler,
all team members within some distance of you will start walking towards you at speeds 1 2 3 4 (and note that running at
speed, say, 2 consumes twice as much energy as walking at speed 1). If two team members are hollering
then everyone else heads towards the loudest (breaking ties at random).

Note that hollering is heard all over the world (cause you actually holler via cell phone).

To get your team through a gate, you walk through and holler for them to follow you. Its up to you if you holler first
(to collect them) before trying to get the door open, or afterwards.

### Countries

<img width=300 align=right src="https://whatjaysaid.files.wordpress.com/2016/01/forceunconnectedareas.png?w=497">
The world is full of square countries. Cross each country takes time that is square root of its area.
In one country you can see all the doors to other countries, the depth of the
footsteps in this country, how many apples and puppies are found there and how many
team members in this country (so you could peek into a country and see if someone is stuck).
Ditto for any neighboring country 
connected by open doors.

With two exceptions, team members only have access to anything the see while walking around; i.e. anything in the country they cross or anything they see in a neighboring country. The two exceptions are:

- hollering, which is audible all over the world.
- "chains" where team members stand together in adjacent countries and tell each other what they see around each other.

### Doors and Gatekeepers

Countries are connected by doors. Each door has its own separate 
gatekeepers 
who you must meet
persuade to let open the door. Doors stay open for some period of time, then close.  

Gatekeepers are of one of four types, depending on how they respond to arguments.
You won't know what until
you try (which BTW, means that coming back with the puppies is faster cause you'll know how to reason 

Note that all the following     strategies require background knowledge and one of the tasks of this 
project is to determine how to express that background knowledge in an elegant language.

<img align=right width=400 src="https://i.pinimg.com/originals/cb/3b/f3/cb3bf3270c1f529b5b1523c4e8ba5435.jpg">

#### Ethos: authority, credibility

- e.g. countries are in empires and team members are related to the king. "don't you know who i am? I am the queen's son!"
- e.g. gatekeepers work in gangs and you can present a letter from a gang boss saying you can pass. 
- e.g. your king presents you with some passport that opens some doors
    her's a piece of paper authorizing us

#### Pathos: emotional appeal

- e.g. you can tell the story of orphans back home that will starve unless you can get puppies
- e.g. you deliberately wear down your food supply then show the gatekeeper your younger team member and say "look at this wretch, he's starving! let us through so we can get more food next door."


#### Logos: rational appeal

Anything to do with facts and figures and numbers and logic

- e.g. we are eating apples here at the following rate. if you don't let us pass, we'll eat you out of house and home
- e.g. let us through and we will pay you a few of N apples

#### Kairos: timely

"A passing instant when an opening appears which must be driven through with force if success is to be achieved."

-  e.g. You wait till Sunday when the gatekeeper leaves the gate open when she goes visits her Mum.
- e.g. The gatekeeper likes a drink. You cannibalize your apples to make cider.



## What to do

### Project1 (due end Jan): 3 marks

Code a bare bones versions of the above. All doors are open, no gatekeepers

- Random walk of the world, eating whatever, getting stuck sometime.
- Pick control parameters such that your team usually gets round to most parts of the world.

### Project2 (due end Feb): 7 marks (+4 bonus)

All the above spec coded in dirty raw Python

- 2 extra marks: code tabu search and submit charts showing the effects of tabu search off or tabu search on.
- 2 extra marks: code ant colony optimization and present charts showing the effects of ACO off or ACO on.

### Project3 (due end March):  10  marks

Phase2 re-written as a beautiful DSL.

### Phase4 (due end April): (code=10, report=10, talk=5, cool=5) marks

- Your phase3 code will be reviewed and various challenge problems will be set. 
- In  phase4, you will attempt to address those challenges. 
     - Note: is not expected that all challenges will be meet
- You will present you game (10 mins max) and a "coolness" grade (out of 5) will be assigned.

For phase4, you also have to include a file pro4/report.pdf which is a   five page (or more) document describing the styles and idioms you used in your language, what problem they solved,
and how you implemented them. The goal of this document is to show that you understand language choices.
That report should be generated from  Word or Latex using
       [these templates](https://www.acm.org/publications/proceedings-template-16dec2016);
        e.g. [this doc](https://www.acm.org/binaries/content/assets/publications/article-templates/sig-alternate-sample.pdf)
Reports
that are too short or expand font size or margins sizes will lose points proportional
        to that expansion.
	
## What to hand in

In your Github repo XXX,  subdirectories called proj1, proj2, proj3, proj4 each:

- containing its own `__main__.py` file.
- containing a file log.out showing a transcript of the game in action

Your code will be tested as follows:

    cd XXX
    python3 proj1


