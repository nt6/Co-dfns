﻿:Namespace union_tests

F←{⊃((⎕DR ⍵)645)⎕DR ⍵}

union∆01_TEST←'union∆Run'#.util.MK∆T2 (⍬)(⍬)
union∆02_TEST←'union∆Run'#.util.MK∆T2 (1)(⍬)
union∆03_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(⍬)
union∆04_TEST←'union∆Run'#.util.MK∆T2 (?10⍴5)(⍬)
union∆05_TEST←'union∆Run'#.util.MK∆T2 (1)(1)
union∆06_TEST←'union∆Run'#.util.MK∆T2 (⍬)(1)
union∆07_TEST←'union∆Run'#.util.MK∆T2 (⍬)(⍳5)
union∆08_TEST←'union∆Run'#.util.MK∆T2 (⍬)(?10⍴5)
union∆09_TEST←'union∆Run'#.util.MK∆T2 (1)(⍳5)
union∆10_TEST←'union∆Run'#.util.MK∆T2 (1)(?10⍴5)
union∆11_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(⍳5)
union∆12_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(?10⍴5)
union∆13_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(20+?10⍴5)
union∆14_TEST←'union∆Run'#.util.MK∆T2 (10+⍳5)(?10⍴5)
union∆15_TEST←'union∆Run'#.util.MK∆T2 (?10⍴5)(?10⍴5)
union∆16_TEST←'union∆Run'#.util.MK∆T2 (10+?10⍴5)(?10⍴5)
union∆17_TEST←'union∆Run'#.util.MK∆T2 (?10⍴5)(10+?10⍴5)
union∆18_TEST←'union∆Run'#.util.MK∆T2 (?50⍴100)(?50⍴100)
union∆19_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(⍬)
union∆20_TEST←'union∆Run'#.util.MK∆T2 (F 1)(⍬)
union∆21_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(⍬)
union∆22_TEST←'union∆Run'#.util.MK∆T2 (F ?10⍴5)(⍬)
union∆23_TEST←'union∆Run'#.util.MK∆T2 (F 1)(1)
union∆24_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(1)
union∆25_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(⍳5)
union∆26_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(?10⍴5)
union∆27_TEST←'union∆Run'#.util.MK∆T2 (F 1)(⍳5)
union∆28_TEST←'union∆Run'#.util.MK∆T2 (F 1)(?10⍴5)
union∆29_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(⍳5)
union∆30_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(?10⍴5)
union∆31_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(20+?10⍴5)
union∆32_TEST←'union∆Run'#.util.MK∆T2 (F 10+⍳5)(?10⍴5)
union∆33_TEST←'union∆Run'#.util.MK∆T2 (F ?10⍴5)(?10⍴5)
union∆34_TEST←'union∆Run'#.util.MK∆T2 (F 10+?10⍴5)(?10⍴5)
union∆35_TEST←'union∆Run'#.util.MK∆T2 (F ?10⍴5)(10+?10⍴5)
union∆36_TEST←'union∆Run'#.util.MK∆T2 (F ?50⍴100)(?50⍴100)
union∆37_TEST←'union∆Run'#.util.MK∆T2 (⍬)(F ⍬)
union∆38_TEST←'union∆Run'#.util.MK∆T2 (1)(F ⍬)
union∆39_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(F ⍬)
union∆40_TEST←'union∆Run'#.util.MK∆T2 (?10⍴5)(F ⍬)
union∆41_TEST←'union∆Run'#.util.MK∆T2 (1)(F 1)
union∆42_TEST←'union∆Run'#.util.MK∆T2 (⍬)(F 1)
union∆43_TEST←'union∆Run'#.util.MK∆T2 (⍬)(F ⍳5)
union∆44_TEST←'union∆Run'#.util.MK∆T2 (⍬)(F ?10⍴5)
union∆45_TEST←'union∆Run'#.util.MK∆T2 (1)(F ⍳5)
union∆46_TEST←'union∆Run'#.util.MK∆T2 (1)(F ?10⍴5)
union∆47_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(F ⍳5)
union∆48_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(F ?10⍴5)
union∆49_TEST←'union∆Run'#.util.MK∆T2 (⍳5)(F 20+?10⍴5)
union∆50_TEST←'union∆Run'#.util.MK∆T2 (10+⍳5)(F ?10⍴5)
union∆51_TEST←'union∆Run'#.util.MK∆T2 (?10⍴5)(F ?10⍴5)
union∆52_TEST←'union∆Run'#.util.MK∆T2 (10+?10⍴5)(F ?10⍴5)
union∆53_TEST←'union∆Run'#.util.MK∆T2 (?10⍴5)(F 10+?10⍴5)
union∆54_TEST←'union∆Run'#.util.MK∆T2 (?50⍴100)(?F 50⍴100)
union∆55_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(F ⍬)
union∆56_TEST←'union∆Run'#.util.MK∆T2 (F 1)(F ⍬)
union∆57_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(F ⍬)
union∆58_TEST←'union∆Run'#.util.MK∆T2 (F ?10⍴5)(F ⍬)
union∆59_TEST←'union∆Run'#.util.MK∆T2 (F 1)(F 1)
union∆60_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(F 1)
union∆61_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(F ⍳5)
union∆62_TEST←'union∆Run'#.util.MK∆T2 (F ⍬)(F ?10⍴5)
union∆63_TEST←'union∆Run'#.util.MK∆T2 (F 1)(F ⍳5)
union∆64_TEST←'union∆Run'#.util.MK∆T2 (F 1)(F ?10⍴5)
union∆65_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(F ⍳5)
union∆66_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(F ?10⍴5)
union∆67_TEST←'union∆Run'#.util.MK∆T2 (F ⍳5)(F 20+?10⍴5)
union∆68_TEST←'union∆Run'#.util.MK∆T2 (F 10+⍳5)(F ?10⍴5)
union∆69_TEST←'union∆Run'#.util.MK∆T2 (F ?10⍴5)(F ?10⍴5)
union∆70_TEST←'union∆Run'#.util.MK∆T2 (F 10+?10⍴5)(F ?10⍴5)
union∆71_TEST←'union∆Run'#.util.MK∆T2 (F ?10⍴5)(F 10+?10⍴5)
union∆72_TEST←'union∆Run'#.util.MK∆T2 (F ?50⍴100)(?F 50⍴100)

:EndNamespace

