!Tag class methods!
handles
	^'someImpossibBle STRing'
!
handlerOf: line
	   self allSubclasses do: [:class|
	   	line ~ class handles ifTrue: [^class]].
	    ^TagError
!!
! TagError methods !
line: string for: this at: line
    self error: ('I do not know how to handle [', line s)
!!

! TagBlank  class methods ! 
handles 
    ^'^\s*$' 
!
! TagBlank methods ! 
line: string for: this at: line 
       ('blank line ', line s) oo.
        ^self 
!!
! TagRule class methods ! 
	handles ^'^\s*\w+\s+->(\s+\w+)*\s*$' 
!!
! TagRule methods ! 
line: string for: this at: line
	|words|
	words := string asWords.
	this lhs: words first rhs: (words from: 3)
!!

! TagAssign class methods ! 
handles 
    ^'^\s*\w+\s+=(\s+\w+)+\s*$' 
!!
! TagAssign       methods ! 
line: string for: this at: line
!!



