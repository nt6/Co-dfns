﻿:Namespace codfns
⍝ === VARIABLES ===

APLPrims←(,'+') (,'-') (,'÷') (,'×') (,'|') (,'*') (,'⍟') (,'⌈') (,'⌊') (,'<') (,'≤') (,'=') (,'≠') (,'≥') (,'>') (,'⌷') (,'⍴') (,',') (,'⍳') '⎕ptred' '⎕index' '⎕coeffred' (,'¨')

APLRtOps←,⊂'codfns_each'

_←⍬
_,←'codfns_add' 'codfns_subtract' 'codfns_divide' 'codfns_multiply' 'codfns_residue' 'codfns_power'
_,←'codfns_log' 'codfns_max' 'codfns_min' 'codfns_less' 'codfns_lesseq' 'codfns_equal' 'codfns_not_equal'
_,←'codfns_greateq' 'codfns_greater' 'codfns_squad' 'codfns_reshape' 'codfns_catenate' 'codfns_indexgen'
_,←'codfns_ptred' 'codfns_index' 'codfns_coeffred'
APLRunts←_

CC←'nvcc -O3 -g -shared -Xcompiler -fPIC -Irt -Xlinker -L. -o '

CodfnsRuntime←'./libcodfns.so'

LLVMCore←'libLLVM-3.5.so'

LLVMExecutionEngine←'libLLVM-3.5.so'

LLVMX86CodeGen←'libLLVM-3.5.so'

LLVMX86Desc←'libLLVM-3.5.so'

LLVMX86Info←'libLLVM-3.5.so'

MtA←0 2⍴⊂''

MtAST←0 4⍴0

MtNTE←0 2⍴⊂''

Target←'X86'

TargetTriple←'x86_64-redhat-linux-gnu'

WithGPU←1

⎕ex '_'

⍝ === End of variables definition ===

(⎕IO ⎕ML ⎕WX)←0 1 3

 AP←{1 3∨.=10|⎕DR ⍵:ffi_make_array_int 1(≢⍴⍵)(≢,⍵)(⍴⍵)(,⍵)
     5∨.=10|⎕DR ⍵:ffi_make_array_double 1(≢⍴⍵)(≢,⍵)(⍴⍵)(,⍵)
     E 99}

 AV←{⍝ Anchor Variables
     w←⊃⍪/((~m)/w),(m←t/t∧(1⌷⍉⍵)∊⊂'FuncExpr')/w←⍵⊂[0]⍨t←1,1↓1=0⌷⍉⍵
     sb←(k←+\1⌽(1⌷⍉w)∊⊂'Function'){'name'Prop ⍵⌿⍨(1⌷⍉⍵)∊⊂'Expression'}⌸w
     sk←↑,∘⍎¨(gc←'coord'∘Prop)w ⋄ gn←'name'∘Prop
     a←{b←sb[sk⍳{k[⍒k;]⊣k←↑(↓sk)∩(≢⍵)↑¨(1+⍳⍵⍳0)↑¨⊂⍵},⍎⊃gc ⍵;] ⋄ s←⍴b ⋄ b←,b ⋄ w←⍵
         v←(~v\(gn v⌿⍵)∊,¨'⍺⍵')∧(v\(1⌷⍉(1⌽v)⌿⍵)∊⊂'Expression')∧v←(1⌷⍉⍵)∊⊂'Variable'
         (3⌷⍉v⌿w)⍪←'env' 'slot'∘{⍺,⍪⍕¨2↑⍵}¨↓⍉s⊤b⍳gn v⌿⍵ ⋄ ⊂w}
     ⊃⍪/k a⌸w}

 Bind←{0=≢⍵:⍵ ⋄ (i←A⍳⊂'name')≥⍴A←0⌷⍉⊃0 3⌷Ast←⍵:Ast⊣(⊃0 3⌷Ast)⍪←'name'⍺
     Ast⊣((0 3)(i 1)⊃Ast){⍺,⍵,⍨' ' ''⊃⍨0=⍴⍺}←⍺}

 ByDepth←{(⍵=⍺[;0])⌿⍺
 }

 ByElem←{(⍺[;1]∊⊂⍵)⌿⍺
 }

 CL←{⍵,'.so'⊣⎕SH CC,'"',⍵,'.so" "',⍵,'.c" -lcodfns'
 }

 CP←{ast←⍵
     pm←(1⌷⍉⍵)∊⊂'Primitive'               ⍝ Mask of Primitive nodes
     pn←'name'Prop pm⌿⍵                   ⍝ Primitive names
     cn←(APLPrims⍳pn)⌷¨⊂APLRunts⍪APLRtOps ⍝ Converted names
     hd←⍉⍪'class' 'function'              ⍝ Class is function
     at←(⊂⊂'name')(hd⍪,)¨cn               ⍝ Name of the function
     vn←(⊂'Variable'),(⊂''),⍪at           ⍝ Build the basic node structure
     ast⊣(pm⌿ast)←(pm/0⌷⍉⍵),vn            ⍝ Replace Primitive nodes
 }

 Comment←{⍺
 }

 ConvertArray←{
     s←ffi_get_size ⍵                     ⍝ Get the number of data elements
     t←ffi_get_type ⍵                     ⍝ Type of data
     d←{
         t=2:ffi_get_data_int s ⍵         ⍝ Integer type
         ffi_get_data_float s ⍵           ⍝ Float type
     }⍵
     r←ffi_get_rank ⍵                     ⍝ Get the number of shape elements
     p←ffi_get_shape r ⍵                  ⍝ Get the shapes
     t,⊂p⍴d                               ⍝ Reshape based on shape
 }

 DF←{⊃⍪/(⊂1↑⍵),({1=≢'name'Prop 1↑⍵}¨k)/k←1 Kids ⍵
 }

 DL←{(~⍵[;1]∊⊂'Line')⌿⍵
 }

 DU←{
     e←'Expression'≡∘⊃0 1⌷⊢    ⍝ (e n) indicates a node is an expression
     u←(e∧0=∘≢'name'Prop 1↑⊢)¨ ⍝ (u k) gives map of unnamed exprs
     d←(~(∨\0,1↓¯1⌽u))(/∘⊢)⊢   ⍝ (d k) drops kids after 1st unnamed ex
     f←'Function'≡∘⊃0 1⌷⊢      ⍝ (f n) tests if n is function node
     0=≢k←1 Kids ⍵:⍵           ⍝ Terminate at leaves
     ⊃⍪/(⊂1↑⍵),∇¨d⍣(f ⍵)⊢k     ⍝ Recur after dropping unnamed exprs
 }

 E←{⍺←⊢ ⋄ ⍺ ⎕SIGNAL ⍵
 }

 EA←{#.Codfns.ffi_make_array_double 1 0 0 ⍬ ⍬
 }

 FD←{⍝ Annotate function with their scope depths
     w←⍵ ⋄ d←¯1++/c∧.(=∨0=⊢)⍉c←↑1↓⍎¨'coord'Prop ⍵
     (3⌷⍉((1⌷⍉w)∊⊂'Function')⌿w)⍪←↓(⊂'depth'),⍪⍕¨d ⋄ w}

 FE←{⍝ Flatten Expressions
     ren←{0=≢w←⍵:⍵ ⋄ (0 3⌷w)←⊂(1,⍨~(0⌷⍉a)∊⊂'name')⌿(a←⊃0 3⌷⍵)⍪'name'⍺ ⋄ w}
     mv←{(1+⍺)'Expression' ''(⍉⍪'class' 'atomic')⍪⍉⍪(2+⍺)'Variable' ''(⍉⍪'name'⍵)}
     lf←{m←(⊃⍵)≥0⌷⍉⍵ ⋄ dn←⍉⍪0 '' ''(1 2⍴'name' 'res')
         n←(⊃'name'Prop⊢)¨1↓{(≢n)⊃1↑¨⍺ ⍵⊣n←'name'Prop 1↑⍵}\(⊂dn),p←(⊃m⊂⍺)⊂[0]⊃k←m⊂[0]⍵
         ⊃⍪/(1↓k),⍨⌽((¯1↓b)⍪¨(⊃⍵)mv¨1↓n),¯1↑b←n((⊃⍵){⍺ ren w⊣w[;0]-←⍺⍺-⍨⊃⍵⊣w←⍵})¨p}
     md←(e\('class'Prop e⌿⍵)∊'monadic' 'dyadic')∧e←(1⌷⍉⍵)∊⊂'Expression'
     re←(¯3⌽(1⌷⍉⍵)∊⊂'Condition')∨e∧d=(⊢+⊣×0=⊢)\(e∧1=d←0⌷⍉⍵)+3×(1⌷⍉⍵)∊⊂'Function'
     ⊃⍪/(⊂(e⍳1)↑⍵),lf⌿↑re∘(⊂[0])¨(md∨re)⍵}

∇ Z←FI;C;E;I;G;D;R;P
 Z←⍬ ⋄ R←CodfnsRuntime
 'ffi_get_type'⎕NA'U1 ',R,'|ffi_get_type P'
 'ffi_get_data_int'⎕NA R,'|ffi_get_data_int >I8[] P'
 'ffi_get_data_float'⎕NA R,'|ffi_get_data_float >F8[] P'
 'ffi_get_shape'⎕NA R,'|ffi_get_shape >U8[] P'
 'ffi_get_size'⎕NA'U8 ',R,'|ffi_get_size P'
 'ffi_get_rank'⎕NA'U2 ',R,'|ffi_get_rank P'
 'ffi_make_array_int'⎕NA'I ',R,'|ffi_make_array_int >P U2 U8 <U8[] <I8[]'
 'ffi_make_array_double'⎕NA'I ',R,'|ffi_make_array_double >P U2 U8 <U8[] <F8[]'
 'array_free'⎕NA R,'|array_free P'
 'cstring'⎕NA'libc.so.6|memcpy >C[] P P'
 'strlen'⎕NA'P libc.so.6|strlen P'
 'free'⎕NA'libc.so.6|free P'
∇

 Fix←{n LK⊃Init CL(VF ⍺)WM GC CP FD AV FE LF RF LC DF DU DL⊃a n←PS TK VI ⍵⊣FI
 }

 GC←{com←{⊃,/(⊂''),1↓,',',⍪⍵} ⋄ z←,⊂'#include "codfns.h"'
     di←¯1 ⋄ md←{'D',⍕di⊣(⊃di)+←1} ⋄ si←¯1 ⋄ ms←{'S',⍕si⊣(⊃si)+←1}
     li←¯1 ⋄ ml←{'L',⍕li⊣(⊃li)+←1}
     ce←(tm/1⌽(1⌷⍉⍵)∊⊂'Number')/t←(tm←1=0⌷⍉⍵)⊂[0]⍵
     ntyp←{('int' 'float'⍳⊂⊃'class'Prop 1↓⍵)⊃'type_i' 'type_d' 'type_na'}
     nenm←{'apl_',ntyp ⍵} ⋄ gshp←{'uint64_t ',⍺,'[]={',((1=z)⊃(⍕z←gsz ⍵)''),'};'}
     cnv←{w←⍵ ⋄ (('¯'=w)/w)←'-' ⋄ w}
     gdat←{(ntyp ⍵),' ',⍺,'[]={',(com cnv¨'value'Prop 1↓⍵),'};'}
     gnm←{⊃'name'Prop 1↑⍵} ⋄ gsz←{+/(1⌷⍉⍵)∊⊂'Number'}
     lit←{'struct codfns_array ',(⊃⍺),'={',(com(⊂⍕1≠gsz ⍵),(⍕¨2⍴gsz ⍵),(nenm ⍵)'0',1↓⍺),',NULL};'}
     ptr←{'struct codfns_array *',(gnm ⍵),'=&',⍺,';'}
     arr←{s←ms ⍬ ⋄ d←md ⍬ ⋄ l←ml ⍬ ⋄ (s gshp ⍵)(d gdat ⍵)(l s d lit ⍵)(l ptr ⍵)}
     z,←⊃,/(⊂0⍴⊂''),arr¨ce ⋄ ve←(tm/1⌽(1⌷⍉⍵)∊⊂'Variable')/t
     frm←{⊂'struct codfns_array env0[',(⍕⍵),'];'}
     gvd←{(⍳≢⍺){'struct codfns_array *',⍵,'=&env0[',(⍕⍺),'];'}¨⍺}
     gfh←{⊂'UDF(',⍵,'){'} ⋄ z,←(≢ve)frm⍨⍣(0≠≢ve)⊢⍬
     z,←(gnm¨ve)gvd⍣(0≠≢ve)⊢⍬ ⋄ z,←gfh'Init'
     z,←{' array_cp(',(gnm ⍵),',',(gnm 1↓⍵),');'}¨ve ⋄ z,←⊂' return 0;}'
     gt←{⊂' if(*(type_i*)',(gnm 2↓⍵),'->elements){'}
     gif←{(gt ⍵),(' ',¨ges 3↓⍵),⊂'  return 0;}'}
     gv←{⊂' array_cp(',(com cv¨⍵),');'} ⋄ cv←{'lft' 'rgt'⍵⊃⍨(,¨'⍺⍵')⍳⊂⍵}
     gd←{z l f r←⍵ ⋄ ⊂' ',f,'d(',(com cv¨z l r'env,gpu'),');'}
     gm←{z f r←⍵ ⋄ ⊂' ',f,'m(',(com cv¨z'NULL'r'env,gpu'),');'}
     gom←{z f o r←⍵ ⋄ ⊂' ',o,'m(',(com cv¨z'NULL'r f'env,gpu'),');'}
     god←{z l f o r←⍵ ⋄ ⊂' ',o,'d(',(com cv¨z'NULL'r f'env,gpu'),');'}
     ge←{'Condition'≡⊃0 1⌷⍵:gif ⍵ ⋄ ns←'name'Prop ⍵ ⋄ cl←⊃'class'Prop 1↑⍵
         2=≢ns:gv ns ⋄ 3=≢ns:gm ns ⋄ (4=≢ns)∧'monadic'≡cl:gom ns
         (4=≢ns)∧'dyadic'≡cl:gd ns ⋄ 5=≢ns:god ns ⋄ ⊂''}
     ges←{⍵{⊃,/ge¨((⊃⍺)=0⌷⍉⍺)⊂[0]⍺}⍣(0≠≢⍵)⊢⊂' array_free(res);'}
     ga←{(gfh n,⍵),(⊂' return ',(n←gnm ⍺),'(res,lft,rgt);}')}
     enm←{∪('name'Prop((1⌷⍉⍵)∊⊂'Expression')⌿⍵)~⊂'res'}
     ged←{⊂'struct codfns_array*env[]={env0',(com(⊂''),{'onv[',(⍕⍵),']'}¨⍳⍵),'};'}
     env←{' ',¨(frm≢⍺),(ged⍎'0',⊃'depth'Prop 1↑1↓⍵),⊂'init_env(env0,',(⍕≢⍺),');'}
     mvd←{' ',¨⍵ gvd⍣(0≠≢⍵)⊢⍬}
     gf←{(gfh gnm ⍵),(n env ⍵),(mvd⊢n←enm ⍵),(ges 2↓⍵),⊂' return 0;}'}
     z,←⊃,/(⊂0⍴⊂''),gf¨fn←(tm/1⌽(1⌷⍉⍵)∊⊂'Function')/t
     ⍪z}

 GEPI←{{ConstInt(Int32Type)⍵ 0}¨⍵
 }

 Init←{⍵(I 5⍴0)⊣'I'⎕NA'I4 ',⍵,'|Init P P P P I'
 }

 Kids←{((⍺+⊃⍵)=0⌷⍉⍵)⊂[0]⍵
 }

 LC←{⍝ Lift Constants
     I←¯1 ⋄ mkv←{'LC',⍕I⊣(⊃I)+←1} ⋄ e l←((1⌷⍉a←⍵)∊⊂)¨ns←'Expression' 'Number'
     at←{2 2⍴'name'⍵'class'⍺} ⋄ vn←{'Variable' ''('array'at ⍵)}
     hn←1⌷⍉h←(l∨e∧1⌽l)⌿a ⋄ a[s/⍳⊃⍴a;1+⍳3]←↑vn¨v←mkv¨⍳+/s←2</0,l ⋄ a←(s∨~l)⌿a
     h[(i←{(hn∊⊂⍵)/⍳⊃⍴h})1⊃ns;0]←2 ⋄ h[i⊃ns;0 3]←1,⍪'atomic'∘at¨v ⋄ (1↑a)⍪h⍪1↓a}

 LF←{⍝ Lift functions to top level after resolving
     i←¯1 ⋄ mv←{'LF',⍕i⊣(⊃i)+←1} ⋄ a←↑'class' 'equiv'{⍺ ⍵}¨⊂'ambivalent'
     mn←{2 4⍴⍵'FuncExpr' ''a(⍵+1)'Variable' ''(2 2⍴'name'⍺'class' 'function')}
     up←{w←⍵ ⋄ (0⌷⍉w)-←(⊃⍵)-1 ⋄ w} ⋄ s←{⍵⊂[0]⍨(⍬ 1⊃⍨0≠≢⍵),2≠/∨\0,1↓(⊃⍵)≥0⌷⍉⍵}
     l←(1≠d)∧(d=⌈/f/d←0⌷⍉⍵)∧f←1⌽(1⌷⍉⍵)∊⊂'Function'
     c←↑{h r←2↑s ⍵ ⋄ n←mv ⍬ ⋄ (n Bind up h)(r⍪⍨n mn⊃h)}¨l⊂[0]⍵
     (1↑⍵)⍪(⊃⍪/(⊂MtAST),⊣/c)⍪(1↓⍵⌿⍨~∨\l)⍪⊃⍪/(⊂MtAST),⊢/c}

 LK←{⊃v(⍵{⍵⊣⍵.⍎⍺,'←''',⍺,'''##.NA''',⍺⍺,''' ⋄ 0'})¨⍣(0≠≢v←⊣/⍺⌿⍨2=⊢/⍺)⊂⎕NS ⍬
 }

 PS←{
     0=+/⍵[;1]∊⊂'Token':E 2               ⍝ Deal with Eot Stimuli, Table 233
     fl←⊃1 ¯1⍪.↑⊂⍵ ByDepth 2              ⍝ First and last leafs
     ~fl[;1]∧.≡⊂'Token':E 2               ⍝ Must be tokens
     nms←':Namespace' ':EndNamespace'     ⍝ Correct names of first and last
     ~nms∧.≡'name'Prop fl:E 2             ⍝ Verify correct first and last
     n←'name'Prop ⍵ ByElem'Token'         ⍝ Verify that the Nss and Nse
     2≠+/n∊nms:E 2                        ⍝ Tokens never appear more than once
     ns←0 'Namespace' ''(1 2⍴'name' '')   ⍝ New root node is Namespace
     ns⍪←⍵⌿⍨~(⍳≢⍵)∊(0,⊢,¯1+⊢)⍵⍳fl         ⍝ Drop Nse and Nss Tokens
     tm←(1⌷⍉ns)∊⊂'Token'                  ⍝ Mask of Tokens
     sm←tm\('name'Prop tm⌿ns)∊⊂,'⋄'       ⍝ Mask of Separators
     (sm⌿ns)←1 'Line' ''MtA⍴⍨4,⍨+/sm      ⍝ Replace separators by lines, Tbl 219
     ⍝ XXX: The above does not preserve commenting behavior
     tm←(1⌷⍉ns)∊⊂'Token'                  ⍝ Update token mask
     fm←(,¨'{}')⍳'name'Prop tm⌿ns         ⍝ Which tokens are braces?
     fm←fm⊃¨⊂1 ¯1 0                       ⍝ Convert } → ¯1; { → 1; else → 0
     0≠+/fm:E 2                           ⍝ Verify balance
     (0⌷⍉ns)+←2×+\0,¯1↓fm←tm\fm           ⍝ Push child nodes 2 for each depth
     ns fm←(⊂¯1≠fm)⌿¨ns fm                ⍝ Drop closing braces
     fa←1 2⍴'class' 'ambivalent'          ⍝ Function attributes
     fn←(d←fm/0⌷⍉ns),¨⊂'Function' ''fa    ⍝ New function nodes
     fn←fn,[¯0.5]¨(1+d),¨⊂'Line' ''MtA    ⍝ Line node for each function
     hd←(~∨\fm)⌿ns                        ⍝ Unaffected areas of ns
     ns←hd⍪⊃⍪/(⊂MtAST),fn(⊣⍪1↓⊢)¨fm⊂[0]ns ⍝ Replace { with fn nodes
     k←1 Kids ns                          ⍝ Children to examine
     env←⊃ParseFeBindings/k,⊂MtNTE        ⍝ Initial Fe bindings to feed in
     sd←MtAST env                         ⍝ Seed is an empty AST and the env
     ast env←⊃ParseTopLine/⌽(⊂sd),k       ⍝ Parse each child top down
     ((1↑ns)⍪ast)env                      ⍝ Return assembled AST and env
 }

 ParseExpr←{
     0=⊃⍴⍵:2 MtAST ⍺                      ⍝ Empty expressions are errors
     2::2 MtAST ⍺                         ⍝ Allow instant exit while parsing
     6::6 MtAST ⍺
     11::11 MtAST ⍺
     at←1 2⍴'class' 'atomic'              ⍝ Literals become atomic expressions
     n←(d←⊃⍵)'Expression' ''at            ⍝ One node per group of literals
     p←2</0,m←(d=0⌷⍉⍵)∧(1⌷⍉⍵)∊⊂'Number'   ⍝ Mask and partition of literals
     (0⌷⍉m⌿e)+←1⊣e←⍵                      ⍝ Bump the depths of each literal
     e←⊃⍪/(⊂MtAST),(⊂n)⍪¨p⊂[0]e           ⍝ Add expr node to each literal group
     e←((~∨\p)⌿⍵)⍪e                       ⍝ Attach anything before first literal
     dwn←{a⊣(0⌷⍉a)+←1⊣a←⍵}                ⍝ Fn to push nodes down the tree
     at←1 2⍴'class' 'monadic'             ⍝ Attributes for monadic expr node
     em←d'Expression' ''at                ⍝ Monadic expression node
     at←1 2⍴'class' 'dyadic'              ⍝ Attributes for dyadic expr node
     ed←d'Expression' ''at                ⍝ Dyadic expression node
     at←1 2⍴'class' 'ambivalent'          ⍝ Attributes for operator-derived Fns
     feo←d'FuncExpr' ''at                 ⍝ Operator-derived Functions
     e ne _←⊃{ast env knd←⍵               ⍝ Process tokens from bottom up
         e fe rst←env ParseFuncExpr ⍺       ⍝ Try to parse as a FuncExpr node first
         (0⌷⍉fe)+←1                         ⍝ Bump up the FuncExpr depth to match
         k←(e=0)⊃⍺ fe                       ⍝ Kid is Fe if parsed, else existing kid
         tps←'Expression' 'FuncExpr'        ⍝ Types of nodes
         tps,←'Token' 'Variable'
         4=typ←tps⍳0 1⌷k:⍎'⎕SIGNAL e'       ⍝ Type of node we're dealing with
         nm←⊃'name'Prop 1↑k                 ⍝ Name of the kid, if any
         k←(typ=3)⊃k(n⍪dwn k)               ⍝ Wrap the variable if necessary
         c←knd typ                          ⍝ Our case
         c≡0 0:(k⍪ast)env 1                 ⍝ Nothing seen, Expression
         c≡0 1:⍎'⎕SIGNAL 2'                 ⍝ Nothing seen, FuncExpr
         c≡0 2:⍎'⎕SIGNAL 2'                 ⍝ Nothing seen, Assignment
         c≡0 3:(k⍪dwn ast)env 1             ⍝ Nothing seen, Variable
         c≡1 0:⍎'⎕SIGNAL 2'                 ⍝ Expression seen, Expression
         c≡1 1:(em⍪dwn k⍪ast)env 2          ⍝ Expression seen, FuncExpr
         c≡1 2:ast env 3                    ⍝ Expression seen, Assignment
         c≡1 3:⍎'⎕SIGNAL 2'                 ⍝ Expression seen, Variable
         op←'operator'≡⊃'class'Prop 1↑1↓ast ⍝ Is class of kid ≡ operator?
         mko←{dwn feo⍪(dwn k)⍪2↑1↓ast}      ⍝ Fn to make the FuncExpr node
         op∧c≡2 0:(em⍪(mko ⍬)⍪3↓ast)env 2   ⍝ FuncExpr seen, Operator, Expression
         c≡2 0:(ed⍪(dwn k)⍪1↓ast)env 2      ⍝ FuncExpr seen, Expression
         op∧c≡2 1:(em⍪(mko ⍬)⍪3↓ast)env 2   ⍝ FuncExpr seen, Operator, FuncExpr
         c≡2 1:(em⍪dwn k⍪ast)env 2          ⍝ FuncExpr seen, FuncExpr
         op∧c≡2 2:⍎'⎕SIGNAL 2'              ⍝ FuncExpr seen, Operator, Assignment
         c≡2 2:ast env 3                    ⍝ FuncExpr seen, Assignment
         op∧c≡2 3:(em⍪(mko ⍬)⍪3↓ast)env 2   ⍝ FuncExpr seen, Operator, Variable
         c≡2 3:(ed⍪(dwn k)⍪1↓ast)env 1      ⍝ FuncExpr seen, Variable
         c≡3 0:⍎'⎕SIGNAL 2'                 ⍝ Assignment seen, Expression
         c≡3 1:⍎'⎕SIGNAL 2'                 ⍝ Assignment seen, FuncExpr
         c≡3 2:⍎'⎕SIGNAL 2'                 ⍝ Assignment seen, Assignment
         c≡3 3:(nm Bind ast)((nm 1)⍪env)1   ⍝ Assignment seen, Variable
         ⎕SIGNAL 99                         ⍝ Unreachable
     }/(0 Kids e),⊂MtAST ⍺ 0
     (0⌷⍉e)-←1                            ⍝ Push the node up to right final depth
     0 e ne                               ⍝ Return the expression and new env
 }

 ParseFeBindings←{
     1=≢⍺:⍵                      ⍝ Nothing on the line, done
     fp←'Function' 'Primitive'   ⍝ Looking for Functions and Prims
     ~fp∨.≡⊂0(0 1)⊃⌽k←1 Kids ⍺:⍵ ⍝ Not a function line, done
     ok←⊃⍪/(⊂MtAST),¯1↓k         ⍝ Other children
     tm←(1⌷⍉ok)∊⊂'Token'         ⍝ Mask of all Tokens
     tn←'name'Prop tm⌿ok         ⍝ Token names
     ~∧/tn∊⊂,'←':⎕SIGNAL 2       ⍝ Are all tokens assignments?
     ∨/0=2|tm/⍳≢ok:⎕SIGNAL 2     ⍝ Are all tokens separated correctly?
     vm←(1⌷⍉ok)∊⊂'Variable'      ⍝ Mask of all variables
     vn←'name'Prop vm⌿ok         ⍝ Variable names
     ∨/0≠2|vm/⍳≢ok:⎕SIGNAL 2     ⍝ Are all variables before assignments?
     ~∧/vm∨tm:⎕SIGNAL 2          ⍝ Are there only variables, assignments?
     ⍵⍪⍨2,⍨⍪vn                   ⍝ We're good, return new environment
 }

 ParseFnLine←{cod env←⍵
     1=⊃⍴⍺:(cod⍪⍺)env                     ⍝ Do nothing for empty lines
     cmt←⊃'comment'Prop 1↑⍺               ⍝ Preserve the comment for attachment
     cm←{(,':')≡⊃'name'Prop 1↑⍵}¨1 Kids ⍺ ⍝ Mask of : stimuli, to check for branch
     1<cnd←+/cm:⎕SIGNAL 2                 ⍝ Too many : tokens
     1=0⌷cm:⎕SIGNAL 2                     ⍝ Empty test clause
     splt←{1↓¨(1,cm)⊂[0]⍵}                ⍝ Fn to split on : token, drop excess
     1=cnd:⊃cod env ParseCond/splt ⍺      ⍝ Condition found, parse it
     err ast ne←env ParseExpr 1↓⍺         ⍝ Expr is the last non-error option
     0=err:(cod⍪ast)ne                    ⍝ Return if it worked
     ⎕SIGNAL err                          ⍝ Otherwise error the expr error
 }

 ParseFunc←{
     'Function'≢⊃0 1⌷⍵:2 MtAST ⍵          ⍝ Must have a Function node first
     fn←(fm←1=+\(fd←⊃⍵)=d←0⌷⍉⍵)⌿⍵         ⍝ Get the Function node, mask, depths
     en←⍺⍪⍨1,⍨⍪,¨'⍺⍵'                     ⍝ Extend current environment with ⍺ & ⍵
     sd←MtAST en                          ⍝ Seed value
     cn←1 Kids fn                         ⍝ Lines of Function node
     2::2 MtAST ⍵                       ⍝ Handle parse errors
     11::11 MtAST ⍵                       ⍝ by passing them up
     tr en←⊃ParseFnLine/⌽(⊂sd),cn         ⍝ Parse down each line
     0((1↑fn)⍪tr)((~fm)⌿⍵)                ⍝ Newly parsed function, rest of tokens
 }

 ParseFuncExpr←{
     at←{2 2⍴'class'⍵'equiv'⍺}         ⍝ Fn to build fn attributes
     fn←(¯1+⊃⍵)∘{⍺'FuncExpr' ''⍵}        ⍝ Fn to build FuncExpr node
     pcls←{(~∨\' '=C)/C←⊃'class'Prop 1↑⍵} ⍝ Fn to get class of Primitive node
     nm←⊃'name'Prop 1↑⍵                   ⍝ Name of first node
     isp←'Primitive'≡⊃0 1⌷⍵               ⍝ Is the node a primitive?
     isp:0((fn nm at pcls ⍵)⍪1↑⍵)(1↓⍵)    ⍝ Yes? Use that node.
     isfn←'Variable'≡⊃0 1⌷⍵               ⍝ Do we have a variable
     isfn∧←2=⍺ VarType nm                 ⍝ that refers to a function?
     fnat←''at'ambivalent'              ⍝ Fn attributes for a variable
     isfn:0((fn fnat)⍪1↑⍵)(1↓⍵)           ⍝ If function variable, return
     err ast rst←⍺ ParseFunc ⍵            ⍝ Try to parse as a function
     0=err:0(ast⍪⍨fn at⍨'ambivalent')rst  ⍝ Use ambivalent class if it works
     2 MtAST ⍵                            ⍝ Otherwise, return error
 }

 ParseLineVar←{env cls←⍺
     '←'≡⊃'name'Prop 1↑⍵:2 MtAST          ⍝ No variable named, syntax error
     3>⊃⍴⍵:¯1 MtAST                       ⍝ Valid cases have at least three nodes
     tk←'Variable' 'Token'                ⍝ First two tokens should be Var and Tok
     ~tk∧.≡(0 1)1⌷⍵:¯1 MtAST              ⍝ If not, bad things
     (,'←')≢⊃'name'Prop 1↑1↓⍵:¯1 MtAST    ⍝ 2nd node is assignment?
     vn←⊃'name'Prop 1↑⍵                   ⍝ Name of the variable
     tp←env VarType vn                    ⍝ Type of the variable: Vfo or Vu?
     t←(0=tp)∧(cls=0)                     ⍝ Class zero with Vu?
     t:0,⊂vn env ParseNamedUnB 2↓⍵        ⍝ Then parse as unbound
     t←(2 3 4∨.=tp)∨(0=tp)∧(cls=1)        ⍝ Vfo or unbound with previous Vfo seen?
     t:0,⊂vn 2 env ParseNamedBnd 2↓⍵      ⍝ Then parse as bound to Fn
     ⍝ XXX: Right now we assume that we have only types of 2, or Fns.
     ⍝ In the future, change this to adjust for other nameclasses.
     ¯1 MtAST                             ⍝ Not a Vfo or Vu; something is wrong
 }

 ParseNamedBnd←{vn tp env←⍺
     0=⊃env ParseExpr ⍵:⎕SIGNAL 2         ⍝ Should not be an Expression
     tp≠t←2:⎕SIGNAL 2                     ⍝ The types must match to continue
     err ast←env 1 ParseLineVar ⍵         ⍝ Try to parse as a variable line
     0=err:vn Bind ast                    ⍝ If it succeeds, Bind and return
     ferr ast rst←env ParseFuncExpr ⍵     ⍝ Try to parse as a FuncExpr
     (0=ferr)∧tp=t:vn Bind ast            ⍝ If it works, bind it and return
     t←(1=≢⍵)∧('Variable'≡⊃0 1⌷⍵)         ⍝ Do we have only a single var node?
     t∧←0=env VarType⊃'name'Prop 1↑⍵      ⍝ And is it unbound?
     t:⎕SIGNAL 6                          ⍝ Then signal a value error for unbound
     ¯1=×err:⎕SIGNAL ferr                 ⍝ Signal FuncExpr error if suggested
     ⎕SIGNAL err                          ⍝ Else signal variable line error
 }

 ParseNamedUnB←{vn env←⍺
     err ast←env 0 ParseLineVar ⍵         ⍝ Else try to parse as a variable line
     0=err:vn Bind ast                    ⍝ that worked, so bind it
     ferr ast rst←env ParseFuncExpr ⍵     ⍝ Try to parse as a FuncExpr
     0=ferr:vn Bind ast                   ⍝ It worked, bind it to vn
     ¯1=×err:⎕SIGNAL ferr                 ⍝ Signal FuncExpr error if suggested
     ⎕SIGNAL err                          ⍝ Otherwise signal Variable line error
 }

 ParseTopLine←{cod env←⍵ ⋄ line←⍺
     1=≢⍺:(cod⍪⍺)env                    ⍝ Empty lines, do nothing
     cmt←⊃'comment'Prop 1↑⍺             ⍝ We need the comment for later
     eerr ast ne←env ParseExpr 1↓⍺      ⍝ Try to parse as expression first
     0=eerr:(cod⍪ast Comment cmt)ne     ⍝ If it works, extend and replace
     err ast←env 0 ParseLineVar 1↓⍺     ⍝ Try to parse as variable prefixed line
     0=⊃err:(cod⍪ast Comment cmt)env    ⍝ It worked, good
     ferr ast rst←env ParseFuncExpr 1↓⍺ ⍝ Try to parse as a function expression
     0=⊃ferr:(cod⍪ast Comment cmt)env   ⍝ It worked, extend and replace
     ¯1=×err:⎕SIGNAL eerr               ⍝ Signal expr error if it seems good
     ⎕SIGNAL err                        ⍝ Otherwise signal err from ParseLineVar
 }

 Prop←{(¯1⌽P∊⊂⍺)/P←(⊂''),,↑⍵[;3]
 }

 RF←{⍝ Resolve Functions: Attribute scope coordinate to functions
     rf←1,1↓f←(1⌷⍉⍵)∊⊂'Function' ⋄ c←(1+d)↑⍤¯1+⍀d∘.=⍳1+⌈/0,d←0⌷⍉⍵ ⋄ w←⍵
     (3⌷⍉rf⌿w)⍪←↓(⊂'coord'),⍪⍕¨↓rf⌿c ⋄ w}

 Split←{' '((≠(/∘⊢)(1,(1↓(¯1⌽=))))⊂(≠(/∘⊢)⊢))⍵
 }

 TK←{
     vc←'ABCDEFGHIJKLMNOPQRSTUVWXYZ_'     ⍝ Upper case characters
     vc,←'abcdefghijklmnopqrstuvwxyz'     ⍝ Lower case characters
     vc,←'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß' ⍝ Accented upper case
     vc,←'àáâãäåæçèéêëìíîïðñòóôõöøùúûüþ'  ⍝ Accented lower case
     vc,←'∆⍙'                             ⍝ Deltas
     vc,←'ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ'     ⍝ Underscored alphabet
     vcn←vc,nc←'¯0123456789'              ⍝ Numbers
     tc←'←{}:⋄+-÷×|*⍟⌈⌊<≤=≠≥>⍺⍵⍴⍳,⌷¨'     ⍝ Single Token characters
     ac←vcn,'     ⍝⎕.',tc                 ⍝ All characters
     ~∧/ac∊⍨⊃,/⍵:E 2                      ⍝ Verify we have only good characters
     i←(,¨⍵)⍳¨'⍝' ⋄ t←i↑¨⍵ ⋄ c←i↓¨⍵       ⍝ Divide into comment and code
     t←((⌽∘(∨\)∘⌽¨t)∧∨\¨t←' '≠t)/¨t       ⍝ Strip leading/trailing whitespace
     nsb←t∊':Namespace' ':EndNamespace'   ⍝ Mask of Namespace tokens
     nsl←nsb/t ⋄ nsi←nsb/⍳⍴t              ⍝ Namespace lines and indices
     ti←(~nsb)/⍳⍴t ⋄ t←(~nsb)/t           ⍝ Token indices and non ns tokens
     at←{2 2⍴'name'⍵'class' 'delimiter'}  ⍝ Fn for namespace attributes
     nsl←{,⊂2 'Token' ''(at ⍵)}¨nsl       ⍝ Tokenize namespace elements
     t←{                                  ⍝ Tokenize other tokens
         0=≢t:⍬                             ⍝ Special empty case
         t←{(m/2</0,m)⊂(m←' '≠⍵)/⍵}¨t       ⍝ Split on and remove spaces
         t←{(b∨2≠/1,b←⍵∊tc)⊂⍵}¨¨t           ⍝ Split on token characters
         t←{⊃,/(⊂⍬),⍵}¨t                    ⍝ Recombine lines
         lc←+/l←≢¨t                         ⍝ Token count per line and total count
         t←⊃,/t                             ⍝ Convert to single token vector
         fc←⊃¨t                             ⍝ First character of each token
         iv←(sv←fc∊vc,'⍺⍵')/⍳lc             ⍝ Mask and indices of variables
         ii←(si←fc∊nc)/⍳lc                  ⍝ Mask and indices of numbers
         ia←(sa←fc∊'←⋄:')/⍳lc               ⍝ Mask and indices of separators
         id←(sd←fc∊'{}')/⍳lc                ⍝ Mask and indices of delimiters
         ipm←(spm←fc∊'+-÷×|*⍟⌈⌊,⍴⍳')/⍳lc    ⍝ Mask and indices of monadic primitives
         iom←(som←fc∊'¨')/⍳lc               ⍝ Mask and indices of monadic operators
         ipd←(spd←fc∊'<≤=≠≥>⎕⌷')/⍳lc        ⍝ Mask and indices of dyadic primitives
         tv←1 2∘⍴¨↓(⊂'name'),⍪sv/t          ⍝ Variable attributes
         tv←{1 4⍴2 'Variable' ''⍵}¨tv       ⍝ Variable tokens
         ncls←{('.'∊⍵)⊃'int' 'float'}       ⍝ Fn to determine Number class attr
         ti←{'value'⍵'class'(ncls ⍵)}¨si/t  ⍝ Number attributes
         ti←{1 4⍴2 'Number' ''(2 2⍴⍵)}¨ti   ⍝ Number tokens
         tpm←{1 2⍴'name'⍵}¨spm/t            ⍝ Monadic Primitive name attributes
         tpm←{⍵⍪'class' 'monadic axis'}¨tpm ⍝ Monadic Primtiive class
         tpm←{1 4⍴2 'Primitive' ''⍵}¨tpm    ⍝ Monadic Primitive tokens
         tom←{1 2⍴'name'⍵}¨som/t            ⍝ Monadic Operator name attributes
         tom←{⍵⍪'class' 'operator'}¨tom     ⍝ Monadic Operator class
         tom←{1 4⍴2 'Primitive' ''⍵}¨tom    ⍝ Monadic Operator tokens
         tpd←{1 2⍴'name'⍵}¨spd/t            ⍝ Dyadic primitive name attributes
         tpd←{⍵⍪'class' 'dyadic axis'}¨tpd  ⍝ Dyadic primitive class
         tpd←{1 4⍴2 'Primitive' ''⍵}¨tpd    ⍝ Dyadic primitive tokens
         ta←{1 2⍴'name'⍵}¨sa/t              ⍝ Separator name attributes
         ta←{⍵⍪'class' 'separator'}¨ta      ⍝ Separator class
         ta←{1 4⍴2 'Token' ''⍵}¨ta          ⍝ Separator tokens
         td←{1 2⍴'name'⍵}¨sd/t              ⍝ Delimiter name attributes
         td←{⍵⍪'class' 'delimiter'}¨td      ⍝ Delimiter class attributes
         td←{1 4⍴2 'Token' ''⍵}¨td          ⍝ Delimiter tokens
         t←tv,ti,tpm,tom,tpd,ta,td          ⍝ Reassemble tokens
         t←t[⍋iv,ii,ipm,iom,ipd,ia,id]      ⍝ In the right order
         t←(⊃,/l↑¨1)⊂t                      ⍝ As vector of non-empty lines of tokens
         t←t,(+/0=l)↑⊂⍬                     ⍝ Append empty lines
         t[⍋((0≠l)/⍳⍴l),(0=l)/⍳⍴l]          ⍝ Put empty lines where they belong
     }⍬
     t←(nsl,t)[⍋nsi,ti]                   ⍝ Add the Namespace lines back
     t←c{                                 ⍝ Wrap in Line nodes
         ha←1 2⍴'comment'⍺                  ⍝ Head comment
         h←1 4⍴1 'Line' ''ha                ⍝ Line node
         0=≢⍵:h ⋄ h⍪⊃⍪/⍵                    ⍝ Wrap it
     }¨t
     0 'Tokens' ''MtA⍪⊃⍪/t                ⍝ Create and return tokens tree
 }

 VF←{~(∧/∊' '=⊃0⍴⊂⍵)∧(1≡≢⍴⍵)∧(1≡≡⍵):E 11 ⋄ ⍵
 }

 VI←{~1≡≢⍴⍵:E 11 ⋄ 2≠|≡⍵:E 11 ⋄ ~∧/1≥≢∘⍴¨⍵:E 11 ⋄ ~∧/∊' '=(⊃0⍴⊂)¨⍵:E 11 ⋄ ⍵
 }

 VarType←{(⍺[;1],0)[⍺[;0]⍳⊂⍵]
 }

 WM←{⍺⊣(⊃,/,⍵,⎕UCS 10)put ⍺,'.c'
 }

 put←{tie←{0::⎕SIGNAL ⎕EN ⋄ 22::⍵ ⎕NCREATE 0 ⋄ 0 ⎕NRESIZE ⍵ ⎕NTIE 0}⍵
     size←(¯128+256|128+'UTF-8'⎕UCS ⍺)⎕NAPPEND tie 83 ⋄ 1:rslt←size⊣⎕NUNTIE tie}

 Eachk←{(1↑⍵)⍪⊃⍪/(⊂MtAST),(+\(⊃=⊢)0⌷⍉k)(⊂⍺⍺)⌸k←1↓⍵
 }


 NA←{⍺←⊢ ⋄ fmt←⍺⍺{'I4 ',⍵⍵,'|',(⍺⍺,⍵),' P P P P I'}⍵⍵ ⋄ f←{0=⎕NC'⍺':fm ⍵ ⋄ fd ⍵}
     _←'fm'⎕NA fmt'm' ⋄ _←'fd'⎕NA fmt'd' ⋄ 0≠⊃e o←EA ⍬:E e ⋄ 0≠⊃e w←AP ⍵:E e
     0≠⊃e a←AP ⍺⊣⍬:E e ⋄ 0≠e←⍺ f o a w 0 WithGPU:E e ⋄ t z←ConvertArray o
     _←array_free¨o a w ⋄ _←free¨o a w ⋄ t{0≠⍺:⍵}z}


 ParseCond←{cod env←⍺⍺
     err ast ne←env ParseExpr ⍺           ⍝ Try to parse the test expression 1st
     0≠err:⎕SIGNAL err                    ⍝ Parsing test expression failed
     (0⌷⍉ast)+←1                          ⍝ Bump test depth to fit in condition
     m←(¯1+⊃⍺)'Condition' ''MtA          ⍝ We're returning a condition node
     0=≢⍵:(cod⍪m⍪ast)ne                   ⍝ Emtpy consequent expression
     err con ne←ne ParseExpr ⍵            ⍝ Try to parse consequent
     0≠err:⎕SIGNAL err                    ⍝ Failed to parse consequent
     (0⌷⍉con)+←1                          ⍝ Consequent depth jumps as well
     (cod⍪m⍪ast⍪con)ne                    ⍝ Condition with conseuqent and test
 }


 Sel←{~∨/⍺:⍵ ⋄ g←⍵⍵⍣(⊢/⍺) ⋄ 2=⍴⍺:⍺⍺⍣(⊣/⍺)g ⍵ ⋄ (¯1↓⍺)⍺⍺ g ⍵
 }


:EndNamespace 