"=============================================="
! App class methodsFor: 'variables' !
impatient
	^(Patience := Patience - 1 ) < 0  
!
newId
	Ids := Ids + 1.
	^Ids.
!
random
	^Rand
!  
seed
	^self seed: 1
!
seed: seed
	^(Rand := Random new seed: seed )
!
quiet
	Trace := false 
!
verbose
	Trace := true 
!!

"=============================================="
! App class methodsFor: 'creation' !
ready
	^self reset.
!
reset
	^self reset: 1.
!
resetAny
	^self reset: (Random next*100000) asInteger 
!
reset: seed
	Ids := 0.
	Patience := 20.
	self 	seed: seed;
		quiet 
!!

"=============================================="
! App class methodsFor: 'printing' !
say: message
	Trace ifTrue: [('St> ' s, message ) oo] 
!!
