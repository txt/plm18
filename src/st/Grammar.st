! Grammar class methods !
new
    ^super new initialize 
!!
! Grammar methods !
file: aFileName
    Reader new lines: aFileName for: self
!
generate
    App resetAny.
    ^self rewrite: start
!
generate: start
    self rewrite: start.
!
rewrite: symbol
    (rules includesKey: symbol) 
	ifTrue:  [self rewriteSome: symbol]
        ifFalse: [self rewriteOne: symbol ]
!
rewriteOne: symbol
    (' ',symbol) o
!
rewriteSome: symbol
   |some one|
   some := rules at: symbol.
   one  := some any.
   one rhs do: [:symbol|
       self rewrite: symbol]
!
initialize
    rules := Dictionary new.
!
lhs: lhs rhs: rhs
    |new|
    start ifNil: [start := lhs].
    new := Rule new rhs: rhs; lhs: lhs. 
    (self rulesFor: lhs) add: new
!
rulesFor: lhs
    rules at: lhs ifAbsent: [
	rules at: lhs put: OrderedCollection new.
    ].
    ^rules at: lhs.
!!
