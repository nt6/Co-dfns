:Namespace rotfirst

S←':Namespace' 'Run←{⍺⊖⍵}' ':EndNamespace'
R←':Namespace' 'Run←{7⊖⍵}' ':EndNamespace'
T←':Namespace' 'Run←{¯1⊖⍵}' ':EndNamespace'

'01'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	⍬
'02'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	0
'03'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	(⍳5)
'04'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	(2 3 4⍴⍳5)
'05'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	(17⍴0 1 1 0 0 1 1 1 1 0 0)
'06'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	(0 1 1 0 0 1 1)
'07'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	¯1	(2 3 4⍴0 1 1 0 0 1 1 1 1 0 0)
'08'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	1	(0 1 1 0 0 1 1)
'09'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	7	(17⍴0 1 1 0 0 1 1 1 1 0 0)
'10'('rotfirst' S 'Run' #.util.GEN∆T2 ⎕THIS)	7	(17⍴⍳17)
'11'('rotfirst' R 'Run' #.util.GEN∆T1 ⎕THIS)		(17⍴⍳17)
'12'('rotfirst' T 'Run' #.util.GEN∆T1 ⎕THIS)		(2 3 4⍴⍳5)
'13'('rotfirst' T 'Run' #.util.GEN∆T1 ⎕THIS)		(⍳5)
'14'('rotfirst' T 'Run' #.util.GEN∆T1 ⎕THIS)		0
'15'('rotfirst' T 'Run' #.util.GEN∆T1 ⎕THIS)		(17⍴0 1 1 0 0 1 1 1 1 0 0)
'16'('rotfirst' T 'Run' #.util.GEN∆T1 ⎕THIS)		(0 1 1 0 0 1 1)
'17'('rotfirst' T 'Run' #.util.GEN∆T1 ⎕THIS)		(2 3 4⍴0 1 1 0 0 1 1 1 1 0 0)
'18'('rotfirst' R 'Run' #.util.GEN∆T1 ⎕THIS)		(17⍴0 1 1 0 0 1 1 1 1 0 0)


:EndNamespace

