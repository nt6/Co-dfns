﻿ AV04_TEST←{⍝ X←5{⍺+⍵}5 → LC0⟨0⟩←5 ⋄ LC1⟨1⟩←5 ⋄ LF0←{⍺+⍵} ⋄ X←LC0⟨0;0⟩ LF0 LC1⟨0;1⟩
     z←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' '' 'coord' '1 0 0 0 0 0 0')
     z⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'LF0')
     z⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 3 4 2 0 0 0')
     z⍪←3 'Expression' ''(2 2⍴,¨'class' 'dyadic' 'name' '⍺')
     z⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     z⍪←5 'Variable' ''(1 2⍴,¨'name' '⍺')
     z⍪←4 'FuncExpr' ''(2 2⍴,¨'class' 'monadic' 'equiv' '+')
     z⍪←5 'Primitive' ''(2 2⍴,¨'name' '+' 'class' 'monadic axis')
     z⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     z⍪←5 'Variable' ''(1 2⍴,¨'name' '⍵')
     z⍪←1 'Expression' ''(2 2⍴,¨'name' 'LC0' 'class' 'atomic')
     z⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     z⍪←1 'Expression' ''(2 2⍴,¨'name' 'LC1' 'class' 'atomic')
     z⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     z⍪←1 'Expression' ''(2 2⍴,¨'class' 'dyadic' 'name' 'X')
     z⍪←2 'Expression' ''(1 2⍴,¨'class' 'atomic')
     z⍪←3 'Variable' ''(2 2⍴,¨'name' 'LC0' 'class' 'array')
     z⍪←2 'FuncExpr' ''(2 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent')
     z⍪←3 'Variable' ''(2 2⍴,¨'name' 'LF0' 'class' 'function')
     z⍪←2 'Expression' ''(1 2⍴,¨'class' 'atomic')
     z⍪←3 'Variable' ''(2 2⍴,¨'name' 'LC1' 'class' 'array')
     x←z ⋄ (⊃16 3⌷x)⍪←2 2⍴,¨'env' '0' 'slot' '0'
     (⊃20 3⌷x)⍪←2 2⍴,¨'env' '0' 'slot' '1'
     x←x[0 10 11 12 13 14 15 16 17 18 19 20 1 2 3 4 5 6 7 8 9;]
     _←X x ⋄ C.AV z}