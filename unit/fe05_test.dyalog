﻿ FE05_TEST←{⍝ F←{+⍵} → F←{res←+⍵}
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' 'coord' '1 0 0 0 0 0')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 1 1 0 0 0')
     t⍪←3 'Expression' ''(1 2⍴,¨'class' 'monadic')
     t⍪←4 'FuncExpr' ''(2 2⍴,¨'class' 'monadic' 'equiv' '+')
     t⍪←5 'Primitive' ''(2 2⍴,¨'name' '+' 'class' 'monadic axis')
     t⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     t⍪←5 'Variable' ''(1 2⍴,¨'name' '⍵')
     x←t ⋄ (⊃3 3⌷x)⍪←'name' 'res' ⋄ _←X x ⋄ C.FE t}