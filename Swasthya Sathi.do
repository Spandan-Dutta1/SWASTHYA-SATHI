***DEMOGRAPHICS

tab e1
tab e1 p3, row col /*Gender*/
tab e1 p3,col  /*Gender*/
tab e1 p4,col  
tab e1 p5,col  
tab e1 p6,col  
tab e1 p7,col  
tab e1 p81,col  
tab e1 p13,col


graph box p2, by(,title(Distribution of genders by age)) by(p3)
tab e1 p4, row col /*Religion*/
*AMONG HINDU AND MUSLIMS WHAT PROPORTION OF PEOPLE HAVE ENROLLED OR NOT
graph pie, over(e1) by(, title(Proportion of Swasthya Saathi Enrollment across Hindu and Muslims)) ///
by(p4)plabel(_all percent)

tab e1 p5, row col /*Caste*/

graph pie, over(e1) by(, title(Proportion of Swasthya Saathi Enrollment across the caste groups)) ///
by(p5)plabel(_all percent)

tab e1 p7, row col /*Educational Qualification*/
*ENROLMENT AND EDUCATIONAL QUALIFICATION BAR CHART
histogram p7, discrete frequency addlabel ///
by(, title(Educational Qualificaton of the different people who have enrolled in the Swasthya Saathi Scheme)) by(e1)

graph pie, over(p7) by(, title(Educational Qualificaton of the different people who have enrolled in the Swasthya Saathi Scheme)) by(e1)

tab e1 p81, row col /*Occupation*/
graph pie, over(e1) by(, title(Proportion of Swasthya Saathi Enrollment across the occupation groups)) ///
by(p81)plabel(_all percent)

tab e1 p13, row col /*BPL*/

*IMPORTANT
logit e1 ib(1).p13
kwallis p13, by(e1)
/*SIGNIFICANT*/
logit e1 ib(1).p4
kwallis p4, by(e1) /*significant*/
logit e1 i.p11 /*Most coefficients insignificant*/
kwallis p11, by(e1)

*RECODE OF p9 (FAMILY MEMBERS)
gen p91=0 if p9<=3
replace p91=1 if p9==4
replace p91=2 if p9>=5
label define p91 0 "0-3" 1 "4" 2 "5 and above" 
label value p91 p91
label variable p91 "Recode of number of family members"
order p91,after(p9)

tab p91

logit e1 i.p91
/*THE GROUP WHERE FAMILY MEMBERS ARE 5 OR MORE ARE SIGNIFINCANT ,SO
IT SHOWS THAT AS THE NUMBER OF FAMILY MEMBERS ARE INCREASING THE LIKELIHOOD
OF ENROLMENT IN SSA INCREASES */

test (_b[e1:0.p91] = _b[e1:1.p91]= _b[e1:2.p91])
kwallis p91, by(e1)
/*AT 10% LOS THIS NULL HYPOTHESIS IS REJECTED*/

*RECODE OF p10 (AGED FAMILY MEMBERS)
gen p101=0 if p10==0
replace p101=1 if p10==1
replace p101=2 if p10>=2
label define p101 0 "0" 1 "1" 2 "2 and above" 
label value p101 p101
label variable p101 "Recode of number of aged family members"
order p101,after(p10)

logit e1 i.p101
/*very bad model, coefficients insignificant*/
kwallis p101, by(e1)/*INSIGNIFICNAT*/

*RECODE OF p12 (EARNING MEMBERS)
gen p121=0 if p12==0 | p12==1
replace p121=1 if p12>=2
label define p121 0 "0-1" 1 "1 and above" 
label value p121 p121
label variable p121 "Recode of number of earning family members"
order p121,after(p12)

tab p121
logit e1 i.p121
/*EARNING FAMILY MEMBERS ARE SIGNIFICANT*/

test (_b[e1:0.p121] = _b[e1:1.p121])
/*COEFFICIENTS B/W GROUPS ARE DIFFERENT*/

*MAKING hs BINARY
generate hs1=0 if hs<=1
replace hs1=1 if hs==2
label define hs1 0 "Not Used Card" 1 "Used Card"
label value hs1 hs1
label variable hs1 "Recode of used ss?"
order hs1, after(hs)

logit hs1 i.p11 
/*ALL COEFFICIENTS INSIGNIFICANT EXCEPT 50K-100K CATEGORY
BUT THAT CATEOGY ITSELF IS IRRELAVANT FOR OUR STUDY SO TO SAY*/

***ENROLMENT
*SOURCE OF INFORMATION
tab e2

graph pie, over(e2) title(Sources of information about Swasthya Saathi Card)
/* most important is party worker and government officer, shows that government 
took steps to ensure that people know about it.*/

*PLACE OF APPLICATION FOR ENROLMENT
tab e3
/*DUARE SARKAR IS THE MOST PREVALENT ONE*/

*TIME TAKEN FOR ENROLMENT
tab e9

generate e91=0 if e9<=60
replace e91=1 if e9>60 & e9<=120
replace e91=2 if e9>120 & e9<=180
replace e91=3 if e9>180 & e9<=240
replace e91=4 if e9>240 & e9<=300
label define e91 0 "less than 1 hour" 1 "1-2 hours" 2 "2-3 hours" 3 "3-4 hours" 4 "4-5 hours"
label value e91 e91
label variable e91 "Recode of time spent on enrolment"
order e91,after(e9)

*Most people were able to enroll themselves within 2 hours. Howvver there were 5 people who took 4-5 hours.
tab e91

histogram e91, discrete frequency addlabel title(Time Spent on Enrolment)
*GRAPH SAVED IN DESKTOP

*ATTITUDE OF HUSBAND
tab e12
*around 43% of them were interested, and 37% were indifferent and 20% <->

***KNOWLEDGE ABOUT THE BENEFITS
/*correct- a1,a2,a4,a5- more yes is good
wrong-a3,a6,a7-more no is good*/

tab a1 /*More NO- bad*,32 people dont know-PROBLEM*/
tab a2 /*More YES- good, 21 people dont know*/
tab a3 /*More NO-good, 25 people dont know*/
tab a4 /*More YES-good, 6 people don't know*/
tab a5 /*There is more yes, but more dont know*/
tab a6 /*More NO-good, but 43 people don't know*/
tab a7 /*More NO-good, 25 people dont know*/

*MORE YES IS GOOD GRAPHS
graph pie, over(a1) title(Entitled to travelling allowance of Rs200)
graph pie, over(a2) title(Costs of Emergency Care are covered)
graph pie, over(a4) title(Costs of hospitalization are covered)
graph pie, over(a5) title(Maternity and New Born Costs are Covered)

*MORE NO IS GOOD GRAPHS
graph pie, over(a3) title(Costs of Outpatient Department(OPD)are covered)
graph pie, over(a6) title(SS Card can be used outside WB)
graph pie, over(a7) title(Husband and Son could also register)

***REASONS FOR NON ENROLMENT
ssc install mrtab
mrtab r1-r7
*MOST IMPORTANT REASON WAS CONCERNS ABOUT THE QUALITY OF CARE, FOLLOWED BY NOT REQUIRING GOVT INSURANCE AND OTHER ISSUES REGARDING THE QUALITY OF CARE.

*DONE BEFORE THIS 

***HOSPITALIZATION EPISODE
*Primary Interpretation
tab h1
*122 family's 1 member has been admitted and 7 family's 2 members

tab h5 hs1, nofreq col
tab h6 hs1, nofreq col
*for less than 15 days not used card group is performing better but after that used card is

tab h7 hs1, nofreq col
/*for 15% of who has used card have faced delay due to lack 
of beds and for 10% of people who have not used card has 
faced delay due to lack of beds*/

tab h8 hs1, nofreq col
/*For the people who have used card have more waitng time for admission*/

*Formal Tests
kwallis h5, by(hs1) /*INSIGNIFICANT*/
kwallis h6, by(hs1) /*INSIGNIFICANT*/
kwallis h7, by(hs1) /*INSIGNIFICANT*/
kwallis h8, by(hs1) /*INSIGNIFICANT*/
kwallis h9, by(hs1) /*INSIGNIFICANT*/

logit hs1 h4 /*INSIGNIFICANT COEFFICIENTS*/


/*tab h11(i) hs1*/
kwallis h11a,by(hs1)/*INSIGNIFICANT*/
kwallis h11b,by(hs1)/*INSIGNIFICANT*/
kwallis h11c,by(hs1)/*INSIGNIFICANT*/
kwallis h11d,by(hs1)/*INSIGNIFICANT*/
kwallis h11e,by(hs1)/*INSIGNIFICANT*/
kwallis h11f,by(hs1)/*INSIGNIFICANT*/

*ASKED FOR DEPOSIT WHEN CARD PRESENTED
tab hs1b
*21 persons were asked for deposit when presented card

tab hs1c
*16 people were asked for too many documents

***EXPERIENCE WITH SSA
tab ex2 /*7 people are not satisfied*/

*RATINGS OF THE SERVICES
tab ex3a 
tab ex3b
tab ex3c
tab ex3d

/*INSIGNIFICANT- Coefficients are insignificant*/
/*MODEL OVERALL SIGNIFICANT*/
probit ex2 i.ex3a i.ex3b i.ex3c i.ex3d

/*AROUND 90% OF THE SSA CARD USED HAVE RATED THE SERVICE TO BE GOOD TO OKAYISH 
WITH 50% OF THE PEOPLE RATING IT ABOVE GOOD*/ 

***ENROLLED BUT NOT USED THE CARD
mrtab hs2a-hs2f
/* MOST COMMON REASON
	1. Treatment place not empanelled
	2. Doctor not empanelled
	3. Not aware of benefits
*/

***STATUS OF RESPONDENTS
tab s1 hs, nofreq col

tab s2 hs1, nofreq row

probit hs1 i.s1 i.s2
/*SOME COEFFICIENTS ARE SIGNIFICANT*/
generate hs2=0 if hs==1
replace hs2=1 if hs==2
label define hs2 0 "Not Used" 1 "Used" 
label value hs2 hs2


kwallis s1, by(hs2)

kwallis s2, by(hs2)
