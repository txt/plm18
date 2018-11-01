#Reader      isa: Object with: 'line array handler commentChar'.
#Tag         isa: Object.
#TagError    isa: Tag.
#TagBlank    isa: Tag.
#TagRule     isa: Tag.
#TagAssign   isa: Tag.
#App         isa: Object
             shares: 'Rand Patience Trace Ids'.
#Grammar     isa: App with: 'rules start'.
(#Rule       isa: App with: 'lhs rhs guard') public.
!
