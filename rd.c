﻿NM(add,"add",1,1,DID,MFD,DFD,MT ,MT )NM(sub,"sub",1,1,DID,MFD,DFD,MT ,MT )
NM(mul,"mul",1,1,DID,MFD,DFD,MT ,MT )NM(div,"div",1,1,DID,MFD,DFD,MT ,MT )
NM(max,"max",1,1,DID,MFD,DFD,MT ,MT )NM(min,"min",1,1,DID,MFD,DFD,MT ,MT )
NM(exp,"exp",1,1,DID,MFD,DFD,MT ,MT )NM(log,"log",1,1,MT ,MFD,DFD,MT ,MT )
NM(fac,"fac",1,1,DID,MFD,DFD,MT ,MT )NM(res,"res",1,1,DID,MFD,DFD,MT ,MT )
NM(and,"and",1,1,DID,MT ,DFD,MT ,MT )NM(lor,"lor",1,1,DID,MT ,DFD,MT ,MT )
NM(lth,"lth",1,1,DID,MT ,DFD,MT ,MT )NM(lte,"lte",1,1,DID,MT ,DFD,MT ,MT )
NM(gth,"gth",1,1,DID,MT ,DFD,MT ,MT )NM(gte,"gte",1,1,DID,MT ,DFD,MT ,MT )
NM(eql,"eql",1,1,DID,MT ,DFD,MT ,MT )NM(neq,"neq",1,1,DID,MT ,DFD,MT ,MT )
NM(nan,"nan",1,1,MT ,MT ,DFD,MT ,MT )NM(nor,"nor",1,1,MT ,MT ,DFD,MT ,MT )
NM(cir,"cir",1,1,MT ,MFD,DFD,MT ,MT )NM(not,"not",1,0,MT ,MFD,DFD,MT ,MT )
NM(rot,"rot",0,0,DID,MFD,DFD,MT ,MT )NM(rtf,"rtf",0,0,DID,MFD,DFD,MT ,MT )
NM(red,"red",0,0,DID,MT ,DFD,MT ,MT )NM(rdf,"rdf",0,0,DID,MT ,DFD,MT ,MT )
NM(scn,"scn",0,0,DID,MT ,DFD,MT ,MT )NM(scf,"scf",0,0,DID,MT ,DFD,MT ,MT )
NM(enc,"enc",0,0,DID,MT ,DFD,MT ,MT )NM(dec,"dec",0,0,MT ,MT ,DFD,MT ,MT )
NM(sqd,"sqd",0,0,MT ,MFD,DFD,MT ,MT )NM(brk,"brk",0,0,MT ,MFD,DFD,MT ,MT )
NM(iot,"iot",0,0,MT ,MFD,DFD,MT ,MT )NM(rho,"rho",0,0,MT ,MFD,DFD,MT ,MT )
NM(cat,"cat",0,0,MT ,MFD,DFD,MT ,DAD)NM(ctf,"ctf",0,0,MT ,MFD,DFD,MT ,MT )
NM(trn,"trn",0,0,MT ,MFD,DFD,MT ,MT )NM(rol,"rol",1,0,MT ,MFD,DFD,MT ,MT )
NM(dis,"dis",0,0,MT ,MFD,DFD,MT ,MT )NM(par,"par",0,0,MT ,MFD,DFD,MT ,MT )
NM(eqv,"eqv",0,0,MT ,MFD,DFD,MT ,MT )NM(nqv,"nqv",0,0,MT ,MFD,DFD,MT ,MT )
NM(rgt,"rgt",0,0,MT ,MFD,DFD,MT ,MT )NM(lft,"lft",0,0,MT ,MFD,DFD,MT ,MT )
NM(tke,"tke",0,0,MT ,MFD,DFD,MT ,MT )NM(drp,"drp",0,0,MT ,MFD,DFD,MT ,MT )
NM(unq,"unq",0,0,MT ,MFD,DFD,MT ,MT )NM(int,"int",0,0,MT ,MT ,DFD,MT ,MT )
NM(gdu,"gdu",0,0,MT ,MFD,DFD,MT ,MT )NM(gdd,"gdd",0,0,MT ,MFD,DFD,MT ,MT )
NM(mem,"mem",0,0,MT ,MFD,DFD,MT ,MT )NM(fnd,"fnd",0,0,MT ,MT ,DFD,MT ,MT )

ID(add,0,s32)ID(sub,0,s32)ID(mul,1,s32)ID(div,1,s32)ID(res,0,s32)
ID(min,DBL_MAX,f64)ID(max,-DBL_MAX,f64)ID(exp,1,s32)ID(fac,1,s32)
ID(and,1,s32)ID(lor,0,s32)ID(lth,0,s32)ID(lte,1,s32)ID(eql,1,s32)
ID(gth,0,s32)ID(gte,1,s32)ID(neq,0,s32)ID(enc,0,s32)ID(red,1,s32)
ID(rdf,1,s32)ID(scn,1,s32)ID(scf,1,s32)ID(rot,0,s32)ID(rtf,0,s32)

OD(brk,"brk",scm(l),scd(l),MFD,DFD)
OM(com,"com",scm(l),scd(l),MFD,DFD)
OD(dot,"dot",0,0,MT,DFD)
OD(jot,"jot",(scm(l)&&scm(r)),(scd(l)&&scd(r)),MFD,DFD)
OM(map,"map",1,1,MFD,DFD)
OM(oup,"oup",0,0,MT,DFD)
OD(pow,"pow",scm(l),scd(l),MFD,DFD)
OM(red,"red",0,0,MFD,DFD)
OM(rdf,"rdf",0,0,MFD,DFD)
OD(rnk,"rnk",scm(l),0,MFD,DFD)
OM(scn,"scn",1,1,MFD,MT)
OM(scf,"scf",1,1,MFD,MT)
