﻿ AV05_TEST←{⍝ F←{X←5 ⋄ X+X} → LC0⟨0⟩←5 ⋄ F←{X←LC0⟨1;0⟩ ⋄ X⟨0;0⟩+X⟨0;0⟩}
     t←⍉⍪0 'Namespace' ''(2 2⍴'name' '' 'coord' '1 0 0 0 0 0')
     t⍪←1 'Expression' ''(2 2⍴'name' 'LC0' 'class' 'atomic')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(2 2⍴'class' 'ambivalent' 'coord' '1 2 2 0 0 0')
     t⍪←3 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'X')
     t⍪←4 'Variable' ''(2 2⍴'name' 'LC0' 'class' 'array')
     t⍪←3 'Expression' ''(1 2⍴'class' 'dyadic')
     t⍪←4 'Expression' ''(1 2⍴'class' 'atomic')
     t⍪←5 'Variable' ''(1 2⍴,¨'name' 'X')
     t⍪←4 'FuncExpr' ''(2 2⍴,¨'class' 'monadic' 'equiv' '+')
     t⍪←5 'Primitive' ''(2 2⍴,¨'name' '+' 'class' 'monadic axis')
     t⍪←4 'Expression' ''(1 2⍴'class' 'atomic')
     t⍪←5 'Variable' ''(1 2⍴,¨'name' 'X')
     x←t ⋄ (⊃6 3⌷x)⍪←2 2⍴,¨'env' '1' 'slot' '0'
     x[9 13;3]⍪←2⍴⊂2 2⍴,¨'env' '0' 'slot' '0'
     _←X x ⋄ C.AV t}