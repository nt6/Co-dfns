﻿ AV03_TEST←{⍝ X←5+5 → LC0 ← 5 ⋄ LC1 ← 5 ⋄ X←LC0+LC1
     t←⍉⍪0 'Namespace' ''(2 2⍴'name' '' 'coord' '1 0 0 0')
     t⍪←1 'Expression' ''(2 2⍴'name' 'LC0' 'class' 'atomic')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←1 'Expression' ''(2 2⍴'name' 'LC1' 'class' 'atomic')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←1 'Expression' ''(2 2⍴,¨'class' 'dyadic' 'name' 'X')
     t⍪←2 'Expression' ''(1 2⍴'class' 'atomic')
     t⍪←3 'Variable' ''(2 2⍴'name' 'LC0' 'class' 'array')
     t⍪←2 'FuncExpr' ''(2 2⍴,¨'class' 'monadic' 'equiv' '+')
     t⍪←3 'Primitive' ''(2 2⍴,¨'name' '+' 'class' 'monadic axis')
     t⍪←2 'Expression' ''(1 2⍴'class' 'atomic')
     t⍪←3 'Variable' ''(2 2⍴'name' 'LC1' 'class' 'array')
     x←7↑t ⋄ at←4 2⍴,¨'name' 'LC0' 'class' 'array' 'env' '0' 'slot' '0'
     x⍪←3 'Variable' ''at ⋄ x⍪←3↑8↓t
     at←4 2⍴,¨'name' 'LC1' 'class' 'array' 'env' '0' 'slot' '1'
     x⍪←3 'Variable' ''at ⋄ _←X x ⋄ C.AV t}