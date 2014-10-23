﻿ GC12_TEST←{⍝ F←{1:1 ⋄ 0}
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' 'coord' '1 0 0 0 0 0')
     t⍪←1 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'LC0')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '1' 'class' 'int')
     t⍪←1 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'LC1')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '1' 'class' 'int')
     t⍪←1 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'LC2')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '0' 'class' 'int')
     t⍪←1 'FuncExpr' ''(3 2⍴,¨'class' 'ambivalent' 'equiv' 'ambivalent' 'name' 'F')
     t⍪←2 'Function' ''(2 2⍴,¨'class' 'ambivalent' 'coord' '1 4 4 0 0 0')
     t⍪←3 'Condition' ''(0 2⍴⊂'')
     t⍪←4 'Expression' ''(1 2⍴,¨'class' 'atomic')
     t⍪←5 'Variable' ''(4 2⍴,¨'name' 'LC0' 'class' 'array' 'env' '1' 'slot' '0')
     t⍪←4 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'res')
     t⍪←5 'Variable' ''(4 2⍴,¨'name' 'LC1' 'class' 'array' 'env' '1' 'slot' '1')
     t⍪←3 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'res')
     t⍪←4 'Variable' ''(4 2⍴,¨'name' 'LC2' 'class' 'array' 'env' '1' 'slot' '2')
     x←⍪⊂'#include "codfns.h"'
     x⍪←⊂'uint64_t S0[]={};'
     x⍪←⊂'type_i D0[]={1};'
     x⍪←⊂'struct codfns_array L0={0,1,1,apl_type_i,0,S0,D0,NULL};'
     x⍪←⊂'struct codfns_array *LC0=&L0;'
     x⍪←⊂'uint64_t S1[]={};'
     x⍪←⊂'type_i D1[]={1};'
     x⍪←⊂'struct codfns_array L1={0,1,1,apl_type_i,0,S1,D1,NULL};'
     x⍪←⊂'struct codfns_array *LC1=&L1;'
     x⍪←⊂'uint64_t S2[]={};'
     x⍪←⊂'type_i D2[]={0};'
     x⍪←⊂'struct codfns_array L2={0,1,1,apl_type_i,0,S2,D2,NULL};'
     x⍪←⊂'struct codfns_array *LC2=&L2;'
     x⍪←⍪'UDF(Init){' ' return 0;}'
     x⍪←⊂'UDF(F){'
     x⍪←⊂' struct codfns_array env0[0];'
     x⍪←⊂' struct codfns_array*env[]={env0};'
     x⍪←⊂' init_env(env0,0);'
     x⍪←⊂' if(*(type_i*)LC0->elements){'
     x⍪←⊂'  array_cp(res,LC1);'
     x⍪←⊂'  return 0;}'
     x⍪←⊂' array_cp(res,LC2);'
     x⍪←⊂' return 0;}'
     _←X x ⋄ C.GC t}