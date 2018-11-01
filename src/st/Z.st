|g|
App resetAny.
g := Grammar new.
g file: 'english.rules'.
g inspect.
'-----------------------------------' oo.
10 timesRepeat: [g generate. '' oo. ].
!
