﻿ GC14_TEST←{⍝ F←{{⍵}¨⍵}
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' '' 'coord' '1 0 0 0 0 0 0 0 0')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'LF0')
     t⍪←2 'Function' ''(3 2⍴,¨'class' 'ambivalent' 'coord' '1 1 1 1 1 1 1 0 0' 'depth' '1')
     t⍪←3 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'res')
     t⍪←4 'Variable' ''(1 2⍴,¨'name' '⍵')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(3 2⍴,¨'class' 'ambivalent' 'coord' '1 1 1 0 0 0 0 0 0' 'depth' '0')
     t⍪←3 'Expression' ''(2 2⍴,¨'class' 'monadic' 'name' 'res')
     t⍪←4 'FuncExpr' ''(1 2⍴,¨'class' 'ambivalent')
     t⍪←5 'FuncExpr' ''(2 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent')
     t⍪←6 'Variable' ''(2 2⍴,¨'name' 'LF0' 'class' 'function')
     t⍪←5 'FuncExpr' ''(2 2⍴,¨'class' 'operator' 'equiv' '¨')
     t⍪←6 'Variable' ''(2 2⍴,¨'class' 'function' 'name' 'codfns_each')
     t⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     t⍪←5 'Variable' ''(1 2⍴,¨'name' '⍵')
     x←⍪⊂'#include "codfns.h"'
     x⍪←⍪'UDF(Init){' ' return 0;}'
     x⍪←⊂'UDF(LF0){'
     x⍪←⊂' struct codfns_array env0[0];'
     x⍪←⊂' struct codfns_array*env[]={env0,onv[0]};'
     x⍪←⊂' init_env(env0,0);'
     x⍪←⊂' array_cp(res,rgt);'
     x⍪←⊂' return 0;}'
     x⍪←⊂'UDF(F){'
     x⍪←⊂' struct codfns_array env0[0];'
     x⍪←⊂' struct codfns_array*env[]={env0};'
     x⍪←⊂' init_env(env0,0);'
     x⍪←⊂' codfns_eachm(res,NULL,rgt,LF0,env,gpu);'
     x⍪←⊂' return 0;}'
     _←X x ⋄ C.GC t}