﻿ GC13_TEST←{⍝ F←{X←0}
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' 'coord' '1 0 0 0 0')
     t⍪←1 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'LC0')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '0' 'class' 'int')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 2 2 0 0')
     t⍪←3 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'X')
     t⍪←4 'Variable' ''(4 2⍴,¨'name' 'LC0' 'class' 'array' 'env' '1' 'slot' '0')
     x←⍪⊂'#include "codfns.h"'
     x⍪←⊂'uint64_t S0[]={};'
     x⍪←⊂'type_i D0[]={0};'
     x⍪←⊂'struct codfns_array L0={0,1,1,apl_type_i,0,S0,D0,NULL};'
     x⍪←⊂'struct codfns_array *LC0=&L0;'
     x⍪←⊂'UDF(Init){'
     x⍪←⊂' return 0;}'
     x⍪←⊂'UDF(F){'
     x⍪←⊂' struct codfns_array env0[1];'
     x⍪←⊂' struct codfns_array*env[]={env0};'
     x⍪←⊂' init_env(env0,1);'
     x⍪←⊂' struct codfns_array *X=&env0[0];'
     x⍪←⊂' array_cp(X,LC0);'
     x⍪←⊂' return 0;}'
     _←X x ⋄ C.GC t}