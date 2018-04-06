%%%%%%%%%%%%
grocery= [prefix=(g)
         ,iname=grocery0
         ]+[name   is ''            of string
           ,type   is bag(plastic)  of [bag+plastic
                                       ,jar 
                                       ,box+cardboard
                                       ,bottle+cardboard
                                       ,bottle] 
           ,size   is small         of [small ,medium ,large ]
           ,frozen is n             of [y ,n ]
           ].

g type(T) --> g type = T + _,!.
g type(T) --> g type = T.

g volume(V) --> g volumes(Vs), g size = S,  S/V in Vs.

g volumes([small/1, medium/2, large/3]) --> [].
 
grocery(1,  bread,	 bag(plastic),	    medium, n).
grocery(2,  glop,	 jar,		    small,  n).
grocery(3,  granola,	 box(cardboard),    large,  n).
grocery(4,  iceCream,	 carton(cardboard), medium, y).
grocery(5,  pepsi,	 bottle,	    large,  n).
grocery(6,  potatoChips, bag(plastic),	    medium, n).

%%%%%%%%%%%%
bag=[prefix=(b),iname=bagger0]+  [contents is [] of is_list].

b newBag       --> b bags << [].
b largeItem(I) --> 
	b contents has I,
	{g([name=I,get,size=large],_,_)}.
                      
b largeItems(N)-->
	b w(W), sumof(1,I^W^b(largeItem(I),W,W),N).
b resets --> b zapall.

b volume(V)    --> b w(W), sumof(V, W ^ b(volume1(V),W,W),V).
b volume1(V)   --> b contents has I, {g(volume(V),I,_)}.
b notFull      --> \+ b full.
b full         --> b volume(V), b size(S), V >= S.

order = [ prefix=(o), iname=order0 ] + 
        [ items is [] of is_list].

o resets       --> o zapall.
o item(Name,X) --> {g([name=Name,get],X,X)}.

o item(I)      --> o items in I0, o item(I0,I).
o itemCalled(N)  --> o items in X, {g([name=N,get],X,X)}.

o size(20)     --> [].

bagtest :- bagtest(_,_).
bagtest -->
	o new,
	o items is [bread, 
	             glop, granola,
                     granola,iceCream,
                     potatoChips],
        o volume(V),
	(o full
        -> sayln(full(V))
        ;  sayln(roomForMore(V))).
 
