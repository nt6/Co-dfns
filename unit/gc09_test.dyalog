﻿ GC09_TEST←{⍝ F←{5+5}
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' 'coord' '1 0 0 0 0 0')
     t⍪←1 'Expression' ''(2 2⍴,¨'name' 'LC0' 'class' 'atomic')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←1 'Expression' ''(2 2⍴,¨'name' 'LC1' 'class' 'atomic')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 3 3 0 0 0')
     t⍪←3 'Expression' ''(2 2⍴,¨'class' 'dyadic' 'name' 'res')
     t⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     t⍪←5 'Variable' ''(4 2⍴,¨'name' 'LC0' 'class' 'array' 'env' '1' 'slot' '0')
     t⍪←4 'FuncExpr' ''(2 2⍴,¨'class' 'monadic' 'equiv' '+')
     t⍪←5 'Variable' ''(2 2⍴,¨'class' 'function' 'name' 'codfns_add')
     t⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     t⍪←5 'Variable' ''(4 2⍴,¨'name' 'LC1' 'class' 'array' 'env' '1' 'slot' '1')
     x←⍪'#include "codfns.h"' 'uint64_t S0[]={};' 'type_i D0[]={5};'
     x⍪←⊂'struct codfns_array L0={0,1,1,apl_type_i,0,S0,D0,NULL};'
     x⍪←⊂'struct codfns_array *LC0=&L0;'
     x⍪←⍪'uint64_t S1[]={};' 'type_i D1[]={5};'
     x⍪←⊂'struct codfns_array L1={0,1,1,apl_type_i,0,S1,D1,NULL};'
     x⍪←⊂'struct codfns_array *LC1=&L1;'
     x⍪←⊂'UDF(Init){'
     x⍪←⊂' return 0;}'
     x⍪←⊂'UDF(F){'
     x⍪←⊂' struct codfns_array env0[0];'
     x⍪←⊂' struct codfns_array*env[]={env0};'
     x⍪←⊂' init_env(env0,0);'
     x⍪←⍪' codfns_addd(res,LC0,LC1,env,gpu);' ' return 0;}'
     _←X x ⋄ C.GC t}