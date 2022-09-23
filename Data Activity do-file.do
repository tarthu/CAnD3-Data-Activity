capture clear
capture log close
use "/Users/TimWArthur/Documents/CAnD3/GSS.CA-CAnD3.dta", clear
log using "/Users/TimWArthur/Documents/CAnD3/data_activity.log", replace
set more off

****Cleaning data****

***Creating hh labor variable***

tab com_110
clonevar hhlabor = com_110
recode hhlabor 4/9=.
recode hhlabor 1/2 = 0
recode hhlabor 3 =1
label define hhlabor 0 "Mostly one Person" 1 "Equal"
label values hhlabor hhlabor
tab hhlabor

***Creating education variable***

tab ehg3_01b
clonevar edu = ehg3_01b
recode edu 1/2 = 1
recode edu 3/5 = 2
recode edu 6 = 3
recode edu 7 = 4
recode edu 96/99 = .
label define edu 1 "HS or less" 2 "Some College/Certificate" 3 "Bachelors" 4 "Professional Degree"
label values edu edu
tab edu

***Creating missings variable***

egen missing = rowmiss(hhlabor edu)

***Creating table of descriptives***

tab edu hhlabor if missing==0

***Running regression***

logit hhlabor i.edu
logit hhlabor i.edu, or


log close
