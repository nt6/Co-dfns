﻿:Namespace bs2_tests

GD←{⍉↑(5+?⍵⍴25)(1+?⍵⍴100)(0.25+100÷⍨?⍵⍴1000)}
D←⍉GD 7 ⋄ R←⊃((⎕DR 2↑D)323)⎕DR 2↑D ⋄ L←,¯1↑D 

bs2_TEST←'bs2∆Run' 1e¯10 #.util.MK∆T3 L R

:EndNamespace
