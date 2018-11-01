! Rule class methods !
new
	^super new initialize.
!!
! Rule methods !
initialize
	rhs := OrderedCollection new.
!
printOn: aStream 
   aStream nextPutAll: (lhs s , ' -> ') .
   rhs  asArray  printOn: aStream.
 
!!
