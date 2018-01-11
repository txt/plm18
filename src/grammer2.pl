/* vim: set filetype=prolog  : */


sentence(s(NP,VP))               --> noun_phrase(NP,Num), verb_phrase(VP,Num).

noun_phrase(np(DET, NP2), Num)   --> determiner(DET, Num), noun_phrase2(NP2, Num).
noun_phrase(np(NP2), Num)        --> noun_phrase2(NP2, Num).
noun_phrase2(np2(N), Num)        --> noun(N, Num).
noun_phrase2(np2(ADJ, NP2), Num) --> adjective(ADJ), noun_phrase2(NP2, Num).

verb_phrase(vp(V), Num)          --> verb(V, Num).  
verb_phrase(vp(V, NP), Num)      --> verb(V, Num), noun_phrase(NP, _).

determiner(det(the), _)      --> [the].
determiner(det(a), singular) --> [a].

noun(n(pumpkin), singular)   --> [pumpkin].
noun(n(pumpkins), plural)    --> [pumpkins].
noun(n(lecturer), singular)  --> [lecturer].
noun(n(lecturers), plural)   --> [lecturers].

adjective(adj(possessed))    --> [possessed].

verb(v(scares), singular)    --> [scares].
verb(v(scare), plural)       --> [scare].
