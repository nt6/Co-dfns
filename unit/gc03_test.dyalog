﻿ GC03_TEST←{⍝ X←5 5
     t←⍉⍪0 'Namespace' ''(2 2⍴,¨'name' 'coord' '1 0 0')
     t⍪←1 'Expression' ''(2 2⍴,¨'name' 'LC0' 'class' 'atomic')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←2 'Number' ''(2 2⍴,¨'value' '5' 'class' 'int')
     t⍪←1 'Expression' ''(2 2⍴,¨'class' 'atomic' 'name' 'X')
     t⍪←2 'Variable' ''(4 2⍴,¨'name' 'LC0' 'class' 'array' 'env' '0' 'slot' '0')
     x←⍪'#include "codfns.h"' 'uint64_t S0[]={2};' 'type_i D0[]={5,5};'
     x⍪←⊂'struct codfns_array L0={1,2,2,apl_type_i,0,S0,D0,NULL};'
     x⍪←⊂'struct codfns_array *LC0=&L0;'
     x⍪←⊂'struct codfns_array env0[1];'
     x⍪←⊂'struct codfns_array *X=&env0[0];'
     x⍪←⍪'UDF(Init){' ' array_cp(X,LC0);' ' return 0;}'
     _←X x ⋄ C.GC t}