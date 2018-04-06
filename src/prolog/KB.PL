

% report all known item types 
rule r0
for  check_order
if   fail and order=I with items has N and
     grocery with name=N with type(T)
then spy('~w : ~w isa ~w\n',[I,N,T]).

/*
b1 if   the step is check order
	there is a bag of potato chips
	there is no soft drink bottle
then add one bottle of pepsi to the order
*/

rule b1
for  check_order
if   order=I with items has  potatoChips and  
     not (order=I with items has N and
          grocery with name=N  with type(bottle))
then order=I  with items << pepsi.

/*
b2 if   the step is check order
then    discontinue the check-order step 
	start the bag large items step
*/
rule b2
for  check_order
if   true     
then do(bag_large_items).


/*
b3 if 	the step is bag large items
	there is a large item to be bagged
	there is a large bottle to be bagged
	there is a bag with < 6 large items
then    put the bottle in the bag
*/

rule    b3
for     bag_large_items
if      order=I  with items >> N                and
        grocery with name=N with size=large 
                            with type(bottle)    and
        bag = B with largeItems(L)  and
        L < 6 
then    order=I with change                      and
        bag = B with contents << N.
        
/*
b4      if there step is bag large items
	there is a large item to be bagged
	there is a bag with < 6 large items
then    put the large item in the bag
*/

rule   b4
for    bag_large_items
if     order=I  with items >> N                and
       grocery with name=N with size=large      and
       bag = B with largeItems(L)  and
       L < 6 
then   order=I with change and
       bag = B with contents << N.

/*
b5      if there step is bag large items
	there is a large item to be bagged
then 	start a fresh bag
*/
rule    b5
for     bag_large_items
if      order with items has N                and
        grocery with name=N with size=large      
then    bag=new with change.

rule    b6
for     bag_large_items
if      true
then    do(bag_medium_items).


/*
b8 if   the step is bag medium items
	there is a medium item to be bagged
	there is an empty bag or a bag with medium items
then    put the medium item in the bag
*/

rule    b8
for     bag_medium_items
if      order=I  with items >> N                 and
        grocery with name=N with size=medium     and     
        (bag=B   with contents=[]   or
         (bag=B with contents has C and
          grocery with name=C with size=medium)
        )
then    order=I with change and
        bag=B with contents << N.

/*
b9 if   the step is bag medium items
	there is a medium item to be bagged
then    start a fresh bag
*/

rule    b9
for     bag_medium_items
if      order  with items has N                 and
        grocery with name=N with size=medium     
then    bag=new with change.


rule    b10
for     bag_medium_items
if      true
then    do(bag_small_items).

/*
b11 if  the step is bag small items
	there is a small item
	there is a bag that is not yet full
	the bag does not contain bottles
then    put the small item in the bag
*/
rule    b11
for     bag_small_items
if      order=I  with items >> N               and
        grocery with name=N with size=small     and
        bag=B  with notFull         and
        not (bag=B with contents has C          and
             grocery with name=C with type(bottle))
then    order=I with change and
        bag=B with contents << N.
   
/*
b12 if  the step is bag small s_items
	there is a small item
	there is a bag that is not yet full
then    put the small item in the bag
*/
     
rule    b12
for     bag_small_items
if      order=I with items >> N and
        grocery with name=N with size=small and
        bag=B with notFull   
then    order=I with change and
        bag=B with contents << N.

rule    b13
for     bag_small_items
if      order with items has N and
        grocery with name=N with size=small
then    bag=new with change.

/* must go last */
end_rules.

