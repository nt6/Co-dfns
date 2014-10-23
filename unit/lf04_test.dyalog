﻿ LF04_TEST←{x←C.MtAST ⋄ c←LFPS in⊂'F←{5{⍺+⍵}5}'
     x⍪←0 'Namespace' ''(2 2⍴'name' '' 'coord' '1 0 0 0 0 0 0 0 0')
     x⍪←1 'FuncExpr' ''(3 2⍴'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'LF0')
     x⍪←2 'Function' ''(2 2⍴'class' 'ambivalent' 'coord' '1 3 3 1 2 2 0 0 0')
     x⍪←3 'Expression' ''(⍉⍪'class' 'dyadic')
     x⍪←4 'Expression' ''(⍉⍪'class' 'atomic')
     x⍪←5 'Variable' ''(⍉⍪'name'(,'⍺'))
     x⍪←4 'FuncExpr' ''(2 2⍴'class' 'monadic' 'equiv'(,'+'))
     x⍪←5 'Primitive' ''(2 2⍴'name'(,'+')'class' 'monadic axis')
     x⍪←4 'Expression' ''(⍉⍪'class' 'atomic')
     x⍪←5 'Variable' ''(⍉⍪'name'(,'⍵'))
     x⍪←1 'Expression' ''(2 2⍴'name' 'LC0' 'class' 'atomic')
     x⍪←2 'Number' ''(2 2⍴'value'(,'5')'class' 'int')
     x⍪←1 'Expression' ''(2 2⍴'name' 'LC1' 'class' 'atomic')
     x⍪←2 'Number' ''(2 2⍴'value'(,'5')'class' 'int')
     x⍪←1 'FuncExpr' ''(3 2⍴'class' 'ambivalent' 'equiv' 'ambivalent' 'name'(,'F'))
     x⍪←2 'Function' ''(2 2⍴'class' 'ambivalent' 'coord' '1 3 3 0 0 0 0 0 0')
     x⍪←3 'Expression' ''(⍉⍪'class' 'dyadic')
     x⍪←4 'Expression' ''(⍉⍪'class' 'atomic')
     x⍪←5 'Variable' ''(2 2⍴'name' 'LC0' 'class' 'array')
     x⍪←4 'FuncExpr' ''(2 2⍴'class' 'ambivalent' 'equiv' 'ambivalent')
     x⍪←5 'Variable' ''(2 2⍴'name' 'LF0' 'class' 'function')
     x⍪←4 'Expression' ''(⍉⍪'class' 'atomic')
     x⍪←5 'Variable' ''(2 2⍴'name' 'LC1' 'class' 'array')
     _←X x ⋄ C.LF c}