﻿ GC07_TEST←{⍝ F←{} ⋄ G←{}
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' 'coord' '1 0 0')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 1 1')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'G')
     t⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 1 1')
     x←⍪'#include "codfns.h"' 'UDF(Init){' ' return 0;}'
     x⍪←⊂'UDF(F){'
     x⍪←⊂' struct codfns_array env0[0];'
     x⍪←⊂' struct codfns_array*env[]={env0};'
     x⍪←⊂' init_env(env0,0);'
     x⍪←⍪' array_free(res);' ' return 0;}'
     x⍪←⊂'UDF(G){'
     x⍪←⊂' struct codfns_array env0[0];'
     x⍪←⊂' struct codfns_array*env[]={env0};'
     x⍪←⊂' init_env(env0,0);'
     x⍪←⍪' array_free(res);' ' return 0;}'
     _←X x ⋄ C.GC t}