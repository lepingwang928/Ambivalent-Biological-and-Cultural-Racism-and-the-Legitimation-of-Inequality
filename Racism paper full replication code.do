
/******************************************************************************************
  Project: Ambivalent, Biological, and Cultural Racism and the Legitimation of Inequality
  Purpose: Replication code
  Date:    2026/5/26
******************************************************************************************/

global raw "$root\raw"

**Load data
use "$raw\racism_full data_stata.dta", clear


********************************************************************************
* CONSTRUCT KEY MEASURES
******************************************************************************** 
*Demographics
*age
tab age
lab var age "Age"
gen lgage=log10(age)
tab lgage

*sex
tab sex
tab sex, nol
recode sex (1=1) (2=2) (0=3), gen(sex_r)
lab def sex_r 1 "1 male" 2 "2 female" 3 "3 other"
lab val sex_r sex_r
lab var sex_r "Sex"
tab sex_r

*race - US
tab race if country==1
tab race if country==1, nol
recode race (1=1) (2=2) (4=3) (3=4) (5 6 7 8=5) if country==1, gen(race_us)
lab def race_us 1 "1 White, non-Hispanic" 2 "2 Black, non-Hispanic" 3 "3 Hispanic" 4 "4 Asian" 5 "5 Other", replace
lab val race_us race_us 
tab race_us

*immigrant status
tab immigrant
lab val immigrant yesno
lab var immigrant "Respondent is immigrant"
tab immigrant

*race - NL
recode race (1=1) (2 3 5 8=0) if country==2, gen(race_nl)
lab def race_nl 1 "1 Either White or non-immigrant" 0 "0 Either non-White or immigrant", replace
replace race_nl=1 if country==2&immigrant==0
lab val race_nl race_nl
tab race_nl

*racial & immigrant status - NL
gen whiteandnonimmigrant_nl=.
replace whiteandnonimmigrant_nl=1 if immigrant==0&race==1&country==2
replace whiteandnonimmigrant_nl=0 if whiteandnonimmigrant_nl==.&country==2
lab val whiteandnonimmigrant_nl yesno
tab whiteandnonimmigrant_nl
lab var whiteandnonimmigrant_nl "Both White and non-immigrant (NL)"
tab whiteandnonimmigrant_nl
tab race_nl

*income - US
tab hhincome
tab hhincome if country==1
gen hhincome_us=. if country==1
replace hhincome_us=1 if hhincome<30000&country==1
replace hhincome_us=2 if hhincome>=30000&hhincome<100000&country==1
replace hhincome_us=3 if hhincome>=100000&country==1
replace hhincome_us=4 if hhincome==.&country==1
lab var hhincome_us "Household income U.S."
lab def hhincome_us 1 "1 <30000" 2 "2 30000-100000" 3 "3 >=100000" 4 "4 Unknown"
lab val hhincome_us hhincome_us
tab hhincome_us

*income - NL
tab hhincome if country==2
gen hhincome_nl=. if country==2
replace hhincome_nl=1 if hhincome<15000&country==2
replace hhincome_nl=2 if hhincome>=15000&hhincome<50000&country==2
replace hhincome_nl=3 if hhincome>=50000&hhincome!=.&country==2
replace hhincome_nl=4 if hhincome==.&country==2
lab var hhincome_nl "Household income U.S."
lab def hhincome_nl 1 "1 <15000" 2 "2 15000-50000" 3 "3 >=50000" 4 "4 Unknown", replace
lab val hhincome_nl hhincome_nl
tab hhincome_nl

*education
recode education (1 2=1) (3 4=2) (5 6 7=3) (0 .=4), gen(educat)
lab def educat 1 "1 HS or lower" 2 "2 Some college" 3 "3 College degree or higher" 4 "4 Missing"
lab val educat educat
lab var educat "Education (recoded)"
tab educat

*political ideology
tab pol5
gen pol5_us=pol5 if country==1
gen pol5_nl=pol5 if country==2
lab def pol5_us 1 "Strong Democrat" 2 "Democrat" 3 "Neither" 4 "Republican" 5 "Strong Republican"
lab def pol5_nl 1 "Far Left" 2 "Left" 3 "Middle" 4 "Right" 5 "Far Right"
lab val pol5_us pol5_us  
lab val pol5_nl pol5_nl  
tab pol5_us
tab pol5_nl

*parental education
tab peducation
recode peducation (1 2=1) (3 4=2) (5 6 7=3) (0 .=4), gen(peducat)
lab def peducat 1 "1 HS or lower" 2 "2 Some college" 3 "3 College degree or higher" 4 "4 Missing"
lab val peducat peducat
lab var peducat "Highest parental education (recoded)"
tab peducat

*religious attendance
tab reliattend
tab reliattend, nol

*perception: 1-7
tab ineq_post1
gen perception_income=ineq_post1

tab ineq_post2
gen perception_wealth=ineq_post2

gen perception_econ=(perception_income+perception_wealth)/2
tab perception_econ

tab ineq_post3
gen perception_class=ineq_post3

tab ineq_post4
gen perception_race=ineq_post4


*explanation: 1-5
tab belief_1 //coming from wealthy family: class
tab belief_2 //having highly educated parents: class
gen belief_class=(belief_1+belief_2)/2
tab belief_class


tab belief_3 //having a good education: meritocracy
tab belief_4 //hard work: meritocracy
gen belief_merit=(belief_3+belief_4)/2
tab belief_merit

tab belief_5 //knowing the right ppl: social capital
gen belief_social=belief_5

tab belief_6 //race/skin color: race
gen belief_race=belief_6

tab belief_7 //legal or immigration status: immigration status
gen belief_imm=belief_7

tab belief_8 //religion
gen belief_religion=belief_8

tab belief_9 //being born a man or women: gender
gen belief_gender=belief_9


*attitude: 1-7
tab ineq_post5
gen att_redis=ineq_post5

tab ineq_post6
gen att_race=ineq_post6


*racial beliefs
recode racialattitudes1 (1 2 3=1) (4=2) (5 6 7=3), gen(racatt1_cat3)
lab def racatt 1 "1 Disagree" 2 "2 Neither agree or disagree" 3 "3 Agree"
lab val racatt1_cat3 racatt
lab var racatt1_cat3 "People of some races or ethnic groups are born more intelligent than others"
tab racatt1_cat3

recode racialattitudes2 (1 2 3=1) (4=2) (5 6 7=3), gen(racatt2_cat3)
lab val racatt2_cat3 racatt
lab var racatt2_cat3 "People of some races or ethnic groups are born more hard-working than others"
tab racatt2_cat3

recode racialattitudes3 (1 2 3=1) (4=2) (5 6 7=3), gen(racatt3_cat3)
lab val racatt3_cat3 racatt
lab var racatt3_cat3 "Thinking about the world today, some cultures are better than others"
tab racatt3_cat3


*measurement of biological racist 
tab racialattitudes1
tab racialattitudes2
tab racialattitudes3
gen bracial=.
replace bracial=max(racialattitudes1, racialattitudes2)
lab val bracial attitudes
tab bracial //on a 1-7 scale

gen bracialscale=.
replace bracialscale=1 if bracial<4
replace bracialscale=2 if bracial==4
replace bracialscale=3 if bracial>4&bracial!=.
lab def bracialcat 1 "Non-racist" 2 "Ambiguous" 3 "Racist", modify
lab val bracialscale bracialcat
lab var bracialscale "Racist belief"
tab bracialscale //1 "Non-racist" 2 "Ambiguous" 3 "Racist"

gen bracialscale_restrict=.
replace bracialscale_restrict=1 if bracial==6|bracial==7
replace bracialscale_restrict=0 if bracial<=5
lab val bracialscale_restrict yesno
tab bracialscale_restrict //restrictive: agree or strongly agree

*measurement of cultural racist 
tab racialattitudes3 //on a 1-7 scale
gen cracialscale=.
replace cracialscale=1 if racialattitudes3<4
replace cracialscale=2 if racialattitudes3==4
replace cracialscale=3 if racialattitudes3>4&racialattitudes3!=.
lab def cracialcat 1 "Non-racist" 2 "Ambiguous" 3 "Racist", modify
lab val cracialscale cracialcat
lab var cracialscale "Cultural racist belief"
tab cracialscale //1 "Non-racist" 2 "Ambiguous" 3 "Racist"

gen cracialscale_restrict=.
replace cracialscale_restrict=1 if racialattitudes3==6|racialattitudes3==7
replace cracialscale_restrict=0 if racialattitudes3<=5
lab val cracialscale_restrict yesno
tab cracialscale_restrict //restrictive: agree or strongly agree



********************************************************************************
* ANALYTIC SAMPLE DEFINITION
********************************************************************************

* Core completeness conditions (shared across both samples)
gen sample_us = (country == 1)
gen sample_nl = (country == 2)

foreach v of varlist perception_income perception_class perception_race belief_merit belief_1 belief_race att_redis att_race bracialscale cracialscale treatment sex_r lgage religion reliattend educat {
    replace sample_us = 0 if `v' == . & country == 1
    replace sample_nl = 0 if `v' == . & country == 2
}

* Country-specific variables
foreach v of varlist race_us hhincome_us pol5_us {
    replace sample_us = 0 if `v' == . & country == 1
}
foreach v of varlist race_nl hhincome_nl pol5_nl {
    replace sample_nl = 0 if `v' == . & country == 2
}

lab val sample_us yesno
lab val sample_nl yesno

tab sample_us   // n = 2,501
tab sample_nl   // n = 1,636


********************************************************************************
* examine the number of missing cases for each variable
********************************************************************************
tab bracialscale if country==1
tab cracialscale if country==1
tab perception_income if country==1
tab perception_class if country==1
tab perception_race if country==1
tab belief_merit if country==1
tab belief_1 if country==1
tab belief_race if country==1
tab att_redis if country==1
tab att_race if country==1
tab treatment if country==1
tab sex_r if country==1
tab age if country==1
tab race_us if country==1
tab religion if country==1
tab reliattend if country==1
tab educat if country==1
tab hhincome_us if country==1
tab pol5_us if country==1

tab bracialscale if country==2
tab cracialscale if country==2
tab perception_income if country==2
tab perception_class if country==2
tab perception_race if country==2
tab belief_merit if country==2
tab belief_1 if country==2
tab belief_race if country==2
tab att_redis if country==2
tab att_race if country==2
tab treatment if country==2
tab sex_r if country==2
tab age if country==2
tab race_nl if country==2
tab religion if country==2
tab reliattend if country==2
tab educat if country==2
tab hhincome_nl if country==2
tab pol5_nl if country==2

*recode religion and religious attendance for NL
gen religion_nl=religion if country==2
replace religion_nl=7 if religion_nl==.&country==2
lab val religion_nl religion
tab religion_nl //1645

gen reliattend_nl=reliattend if country==2
replace reliattend_nl=6 if reliattend_nl==.&country==2
lab val reliattend_nl reliattend
tab reliattend_nl //1645

replace reliattend=6 if reliattend==.&country==2
lab val reliattend reliattend
tab reliattend if country==2 //1645


********************************************************************************
*Descriptive statistics of racism-related variables
********************************************************************************
tab bracialscale if sample_us==1|sample_nl==1
tab bracialscale if country==1&sample_us==1
tab bracialscale if country==2&sample_nl==1

*distribution of biological & cultural racism  
foreach stub in bracialscale cracialscale {
    tab `stub' if sample_us == 1 | sample_nl == 1, gen(d`stub')
    forval k = 1/3 {
        ttest d`stub'`k' if sample_us == 1 | sample_nl == 1, by(country)
    }
}

foreach var of varlist bcracist bcracist_restrict ambivalentbcracist ///
    bracialscale_restrict cracialscale_restrict {
    ttest `var' if sample_us == 1 | sample_nl == 1, by(country)
}

*prevalence of blatant biological or cultural racism (inclusive)
gen bcracist=.
replace bcracist=1 if bracialscale==3|cracialscale==3
replace bcracist=0 if bracialscale!=3&cracialscale!=3
lab val bcracist yesno
tab bcracist

tab bcracist if (country==1&sample_us==1)|(country==2&sample_nl==1)
tab bcracist if country==1&sample_us==1
tab bcracist if country==2&sample_nl==1
ttest bcracist if sample_us==1|sample_nl==1, by(country)

*prevalence of blatant biological or cultural racism (restrictive)
tab bracialscale_restrict
tab cracialscale_restrict
gen bcracist_restrict=.
replace bcracist_restrict=1 if bracialscale_restrict==1|cracialscale_restrict==1
replace bcracist_restrict=0 if bracialscale_restrict==0&cracialscale_restrict==0
lab val bcracist_restrict yesno
tab bcracist_restrict  

tab bcracist_restrict if country==1&sample_us==1
tab bcracist_restrict if country==2&sample_nl==1
ttest bcracist_restrict if sample_us==1|sample_nl==1, by(country)

tab bracialscale if country==1&sample_us==1
tab cracialscale if country==1&sample_us==1
tab bracialscale if country==2&sample_nl==1
tab cracialscale if country==2&sample_nl==1

*prevalence of blatant biological racism (restrictive)
tab bracialscale_restrict if country==1&sample_us==1
tab bracialscale_restrict if country==2&sample_nl==1
tab bracialscale_restrict
ttest bracialscale_restrict if sample_us==1|sample_nl==1, by(country)

*prevalence of blatant cultural racism (restrictive)
tab cracialscale_restrict if country==1&sample_us==1
tab cracialscale_restrict if country==2&sample_nl==1
tab cracialscale_restrict
ttest cracialscale_restrict if sample_us==1|sample_nl==1, by(country)

*prevalence of ambivalent biological or cultural racism (inclusive)
gen ambivalentbcracist=.
replace ambivalentbcracist=1 if bracialscale==2|cracialscale==2
replace ambivalentbcracist=0 if bracialscale!=2&cracialscale!=2
lab val ambivalentbcracist yesno
tab ambivalentbcracist
tab ambivalentbcracist if (country==1&sample_us==1)|(country==2&sample_nl==1)
tab ambivalentbcracist if country==1&sample_us==1
tab ambivalentbcracist if country==2&sample_nl==1
ttest ambivalentbcracist if sample_us==1|sample_nl==1, by(country)

gen ambivalentbracist=.
replace ambivalentbracist=1 if bracialscale==2
replace ambivalentbracist=0 if bracialscale==1|bracialscale==3
lab val ambivalentbracist yesno
tab ambivalentbracist

*prevalence of ambivalent biological racism (inclusive)
tab ambivalentbracist if country==1&sample_us==1
tab ambivalentbracist if country==2&sample_nl==1
ttest ambivalentbracist if sample_us==1|sample_nl==1, by(country)

gen ambivalentcracist=.
replace ambivalentcracist=1 if cracialscale==2
replace ambivalentcracist=0 if cracialscale==1|cracialscale==3
lab val ambivalentcracist yesno
tab ambivalentcracist

*prevalence of ambivalent cultural racism (inclusive)
tab ambivalentcracist if country==1&sample_us==1
tab ambivalentcracist if country==2&sample_nl==1
ttest ambivalentcracist if sample_us==1|sample_nl==1, by(country)

*prevalence of ambivalent biological or cultural racism (restrictive)
recode bracial (1 2=1) (3 4 5=2) (6 7=3), gen(bracialscale_res_cat3)
lab def bracialscale_res_cat3 1 "Non-racism" 2 "Ambivalent" 3 "Biological racism", replace
lab val bracialscale_res_cat3 bracialscale_res_cat3
tab bracialscale_res_cat3

recode racialattitudes3 (1 2=1) (3 4 5=2) (6 7=3), gen(cracialscale_res_cat3)
lab def cracialscale_res_cat3 1 "Non-racism" 2 "Ambivalent" 3 "Cultural racism", replace
lab val cracialscale_res_cat3 cracialscale_res_cat3
tab cracialscale_res_cat3

gen ambivalentbracist_res=.
replace ambivalentbracist_res=1 if bracialscale_res_cat3==2
replace ambivalentbracist_res=0 if bracialscale_res_cat3==1|bracialscale_res_cat3==3
lab val ambivalentbracist_res yesno
tab ambivalentbracist_res

*prevalence of ambivalent biological racism (restrictive)
tab ambivalentbracist_res if country==1&sample_us==1
tab ambivalentbracist_res if country==2&sample_nl==1
ttest ambivalentbracist_res if sample_us==1|sample_nl==1, by(country)

gen ambivalentcracist_res=.
replace ambivalentcracist_res=1 if cracialscale_res_cat3==2
replace ambivalentcracist_res=0 if cracialscale_res_cat3==1|cracialscale_res_cat3==3
lab val ambivalentcracist_res yesno
tab ambivalentcracist_res

*prevalence of ambivalent cultural racism (restrictive)
tab ambivalentcracist_res if country==1&sample_us==1
tab ambivalentcracist_res if country==2&sample_nl==1
ttest ambivalentcracist_res if sample_us==1|sample_nl==1, by(country)

gen ambivalentbcracist_res=.
replace ambivalentbcracist_res=1 if ambivalentbracist_res==1|ambivalentcracist_res==1
replace ambivalentbcracist_res=0 if ambivalentbracist_res==0&ambivalentcracist_res==0
lab val ambivalentbcracist_res yesno
tab ambivalentbcracist_res

*prevalence of ambivalent biological or cultural racism (restrictive)
tab ambivalentbcracist_res if country==1&sample_us==1
tab ambivalentbcracist_res if country==2&sample_nl==1
ttest ambivalentbcracist_res if sample_us==1|sample_nl==1, by(country)


***********************************************
*Descriptive statistics and t test
***********************************************
*continuous variables (perception, explanation, attitudes about inequality, age)
foreach var of varlist perception_income perception_class perception_race ///
    belief_merit belief_1 belief_race att_redis att_race age {
    ttest `var' if sample_us == 1 | sample_nl == 1, by(country)
}

*categorical variables
*treatment
tab treatment if sample_us==1|sample_nl==1
tab treatment if country==1&sample_us==1
tab treatment if country==2&sample_nl==1

forval k = 1/4 {
    ttest dtreatment`k' if sample_us == 1 | sample_nl == 1, by(country)
}

*sex
tab sex_r if sample_us==1|sample_nl==1
tab sex_r if country==1&sample_us==1
tab sex_r if country==2&sample_nl==1

forval k = 1/4 {
    ttest dtreatment`k' if sample_us == 1 | sample_nl == 1, by(country)
}

*race/ethnicity
tab race_us if country==1&sample_us==1
tab whiteandnonimmigrant_nl if country==2&sample_nl==1

*religion
tab religion if sample_us==1|sample_nl==1
tab religion_nl if country==2&sample_nl==1
replace religion=religion_nl if country==2
forval k = 1/7 {
    ttest dreligion`k' if sample_us == 1 | sample_nl == 1, by(country)
}

*religious attendance
tab reliattend if country==1&sample_us==1
tab reliattend if country==2&sample_nl==1
forval k = 1/6 {
    ttest dreliattend`k' if sample_us == 1 | sample_nl == 1, by(country)
}

*education
forval k = 1/4 {
    ttest deducat`k' if sample_us == 1 | sample_nl == 1, by(country)
}

*income
forval k = 1/3 {
    ttest dhhincome_us`k' == dhhincome_nl`k' if sample_us == 1 | sample_nl == 1, unpaired
}

*political ideology
forval k = 1/5 {
    ttest dpol5_us`k' == dpol5_nl`k' if sample_us == 1 | sample_nl == 1, unpaired
}


********************************************************************************
*ANOVA test for demographic profiles of racial beliefs
********************************************************************************
* Macro to run oneway ANOVA + Tukey pairwise comparisons
cap program drop anova_block
program define anova_block
    args outcome groupvar cond
    oneway `outcome' `groupvar' if `cond'
    pwmean `outcome', over(`groupvar') effects mcompare(tukey)
end

*--- U.S.: Biological racism ---*
foreach v of varlist dsex_r1 dsex_r2 dsex_r3 drace_us1 drace_us2 drace_us3 ///
    drace_us4 drace_us5 dreligion1 dreligion2 dreligion3 dreligion4 dreligion5 ///
    dreligion6 dreliattend1 dreliattend2 dreliattend3 dreliattend4 dreliattend5 ///
    deducat1 deducat2 deducat3 dhhincome_us1 dhhincome_us2 dhhincome_us3 ///
    dpol5_us1 dpol5_us2 dpol5_us3 dpol5_us4 dpol5_us5 {
    anova_block `v' bracial_cat "country==1 & sample_us==1"
}

* Age (continuous)
preserve
    keep if country == 1
    anova_block age bracial_cat "country==1 & sample_us==1"
restore


*--- U.S.: Cultural racism ---*
foreach v of varlist dsex_r1 dsex_r2 dsex_r3 drace_us1 drace_us2 drace_us3 ///
    drace_us4 drace_us5 dreligion1 dreligion2 dreligion4 dreligion5 dreligion6 ///
    dreliattend1 dreliattend2 dreliattend3 dreliattend4 dreliattend5 ///
    deducat1 deducat2 deducat3 dhhincome_us1 dhhincome_us2 dhhincome_us3 ///
    dpol5_us1 dpol5_us2 dpol5_us3 dpol5_us4 dpol5_us5 {
    anova_block `v' cracialscale "country==1 & sample_us==1"
}

* Age (continuous)
preserve
    keep if country == 1
    anova_block age cracialscale "country==1 & sample_us==1"
restore


* Generate NL-specific dummy variables needed for ANOVA
tab whiteandnonimmigrant_nl if country == 2 & sample_nl == 1, gen(dwhiteandnonimmigrant_nl)

*--- Netherlands: Biological racism ---*
foreach v of varlist dsex_rnl1 dsex_rnl2 dwhiteandnonimmigrant_nl1 ///
    dwhiteandnonimmigrant_nl2 dreligionnl1 dreligionnl2 dreligionnl3 ///
    dreligionnl4 dreligionnl5 dreligionnl6 dreliattend1 dreliattend2 ///
    dreliattend3 dreliattend4 dreliattend5 deducatnl1 deducatnl2 deducatnl3 ///
    deducatnl4 dhhincome_nl1 dhhincome_nl2 dhhincome_nl3 dhhincome_nl4 ///
    dpol5_nl1 dpol5_nl2 dpol5_nl3 dpol5_nl4 dpol5_nl5 {
    anova_block `v' bracial_cat "country==2 & sample_nl==1"
}

* Age (continuous)
preserve
    keep if country == 2
    anova_block age       bracial_cat "country==2 & sample_nl==1"
restore

*--- Netherlands: Cultural racism ---*
foreach v of varlist dsex_rnl1 dsex_rnl2 dwhiteandnonimmigrant_nl1 ///
    dwhiteandnonimmigrant_nl2 dreligionnl1 dreligionnl2 dreligionnl3 ///
    dreligionnl4 dreligionnl5 dreligionnl6 dreliattend1 dreliattend2 ///
    dreliattend3 dreliattend4 dreliattend5 deducatnl1 deducatnl2 deducatnl3 ///
    deducatnl4 dhhincome_nl1 dhhincome_nl2 dhhincome_nl3 dhhincome_nl4 ///
    dpol5_nl1 dpol5_nl2 dpol5_nl3 dpol5_nl4 dpol5_nl5 {
    anova_block `v' cracialscale "country==2 & sample_nl==1"
}

* Age (continuous)
preserve
    keep if country == 2
    anova_block age        cracialscale "country==2 & sample_nl==1"
restore


********************************************************************************************************************
*Sensitivity analysis: test the significance of difference in prevalence of biological racism across the U.S. and N.L. for only the mid-age group (age 28-57)
********************************************************************************************************************
local midage "(sample_us==1 | sample_nl==1) & agegroups>=2 & agegroups<=4"

*--- Biological racism ---*
forval k = 1/3 {
    ttest dbracialscale`k' if `midage', by(country)
}

*--- Cultural racism ---*
forval k = 1/3 {
    ttest dcracialscale`k' if `midage', by(country)
}

*prevalence of racism for the mid-age group (ambivalent racism (either), ambivalent biological racism, ambivalent cultural racism)
*--- Prevalence by racism type: country-specific tabs + t-tests ---*
foreach var of varlist ambivalentbcracist ambivalentbracist ambivalentcracist bcracist {
    tab `var' if sample_us == 1 | sample_nl == 1
    tab `var' if country == 1 & sample_us == 1
    tab `var' if country == 2 & sample_nl == 1
    ttest `var' if `midage', by(country)
}

*prevalence of racism for the mid-age group (blatant racism (either), blatant biological racism, blatant cultural racism)
ttest bracialscale if (sample_us==1|sample_nl==1)&agegroups>=2&agegroups<=4, by(country)
ttest bracialscale_restrict if (sample_us==1|sample_nl==1)&agegroups>=2&agegroups<=4, by(country)

* Continuous scale t-tests
foreach var of varlist bracialscale bracialscale_restrict cracialscale cracialscale_restrict {
    ttest `var' if `midage', by(country)
}

*--- Combined mid-age prevalence (US + NL) ---*
foreach var of varlist dbracialscale3 dcracialscale3 bcracist dbracialscale2 ///
    dcracialscale2 ambivalentbcracist {
    tab `var' if `midage'
}


*********************************************************************************************************************
*MLogit regression to explore the demographic profiles of blatant racism, ambivalent racism, or non-racism, where biological racism and cultural racism serve as the outcomes, and the demographic characteristics serve as predictors
*********************************************************************************************************************
local demo_us "i.sex_r lgage i.race_us i.religion i.reliattend i.educat i.hhincome_us i.pol5_us"
local demo_nl "i.sex_r lgage i.whiteandnonimmigrant_nl i.religion i.reliattend i.educat i.hhincome_nl i.pol5_nl"

*--- U.S. ---*
mlogit bracialscale `demo_us' if country == 1 & sample_us == 1
outreg2 using bcracialscale_us_demographic.doc, replace alpha(0.001,0.01,0.05,0.1) ///
    dec(3) symbol(***, **, *, †) cti(biological_racism_us)

mlogit cracialscale `demo_us' if country == 1 & sample_us == 1
outreg2 using bcracialscale_us_demographic.doc, alpha(0.001,0.01,0.05,0.1) ///
    dec(3) symbol(***, **, *, †) cti(cultural_racism_us)

*--- Netherlands ---*
mlogit bracialscale `demo_nl' if country == 2 & sample_nl == 1
outreg2 using bcracialscale_nl_demographic.doc, replace alpha(0.001,0.01,0.05,0.1) ///
    dec(3) symbol(***, **, *, †) cti(biological_racism_nl)

mlogit cracialscale `demo_nl' if country == 2 & sample_nl == 1
outreg2 using bcracialscale_nl_demographic.doc, alpha(0.001,0.01,0.05,0.1) ///
    dec(3) symbol(***, **, *, †) cti(cultural_racism_nl)

	

**********************************************************************************************************
*pooled models with interaction terms to formally test country difference & generate coefficient plots
**********************************************************************************************************
*generate harmonized income measure
gen hhincomecat3=.
replace hhincomecat3=hhincome_us if country==1
replace hhincomecat3=hhincome_nl if country==2
tab hhincomecat3
replace hhincomecat3=2 if hhincomecat3==4
lab val hhincomecat3 hhincomecat3
tab hhincomecat3

*generate harmonized race/ethnicity measure
tab race_us
tab whiteandnonimmigrant_nl
gen whiteyes=.
tab race
tab race, nol
replace whiteyes=1 if race==1
replace whiteyes=0 if race>=2&race<=8
lab val whiteyes yesno
tab whiteyes


* ============================================================
* Color globals for consistency
* ============================================================
lab def bracialscale  1 "Non-racist" 2 "Ambivalent" 3 "Blatant", replace
lab def cracialscale  1 "Non-racist" 2 "Ambivalent" 3 "Blatant", replace
lab val bracialscale bracialscale
lab val cracialscale cracialscale


global blue "26 86 160"    // US (country==1)
global red  "190 30 45"    // Netherlands (country==2)

set scheme plotplainblind

* ============================================================
* PERCEPTIONS AS OUTCOMES - BIOLOGICAL RACISM AS PREDICTOR
* ============================================================

* --- Income ---
reg perception_income i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto p_income_b_us

reg perception_income i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto p_income_b_nl

* --- Class ---
reg perception_class i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto p_class_b_us

reg perception_class i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto p_class_b_nl

* --- Race ---
reg perception_race i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto p_race_b_us

reg perception_race i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto p_race_b_nl


* ============================================================
* PERCEPTIONS AS OUTCOMES - CULTURAL RACISM AS PREDICTOR
* ============================================================

* --- Income ---
reg perception_income i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto p_income_c_us

reg perception_income i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto p_income_c_nl

* --- Class ---
reg perception_class i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto p_class_c_us

reg perception_class i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto p_class_c_nl

* --- Race ---
reg perception_race i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto p_race_c_us

reg perception_race i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto p_race_c_nl


* ============================================================
* EXPLANATIONS AS OUTCOMES - BIOLOGICAL RACISM AS PREDICTOR
* ============================================================

* --- Meritocracy ---
reg belief_merit i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto e_merit_b_us

reg belief_merit i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto e_merit_b_nl

* --- Class ---
reg belief_1 i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto e_class_b_us

reg belief_1 i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto e_class_b_nl

* --- Race ---
reg belief_race i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto e_race_b_us

reg belief_race i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto e_race_b_nl


* ============================================================
* EXPLANATIONS AS OUTCOMES - CULTURAL RACISM AS PREDICTOR
* ============================================================

* --- Meritocracy ---
reg belief_merit i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto e_merit_c_us

reg belief_merit i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto e_merit_c_nl

* --- Class ---
reg belief_1 i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto e_class_c_us

reg belief_1 i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto e_class_c_nl

* --- Race ---
reg belief_race i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto e_race_c_us

reg belief_race i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto e_race_c_nl


* ============================================================
* ATTITUDES AS OUTCOMES - BIOLOGICAL RACISM AS PREDICTOR
* ============================================================

* --- Redistribution ---
reg att_redis i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto a_redis_b_us

reg att_redis i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto a_redis_b_nl

* --- Combat racial discrimination ---
reg att_race i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 1) post
est sto a_race_b_us

reg att_race i.bracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracialscale) at(country = 2) post
est sto a_race_b_nl


* ============================================================
* ATTITUDES AS OUTCOMES - CULTURAL RACISM AS PREDICTOR
* ============================================================

* --- Redistribution ---
reg att_redis i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto a_redis_c_us

reg att_redis i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto a_redis_c_nl

* --- Combat racial discrimination ---
reg att_race i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 1) post
est sto a_race_c_us

reg att_race i.cracialscale##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(cracialscale) at(country = 2) post
est sto a_race_c_nl


* ============================================================
* FIGURE 1: Perceptions of inequality
* ============================================================

coefplot p_income_b_us p_income_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Income", size(medium)) ///
    ylabel(-0.6(0.2)0.4, angle(0) labsize(small)) ///
    ymtick(-0.6(0.1)0.4) ytick(-0.6(0.2)0.4) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "U.S." 2 "Netherlands") pos(6) row(1)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_income_b_us_nl, replace)

coefplot p_class_b_us p_class_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-0.6(0.2)0.4, angle(0) labsize(small)) ///
    ymtick(-0.6(0.1)0.4) ytick(-0.6(0.2)0.4) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_class_b_us_nl, replace)

coefplot p_race_b_us p_race_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-0.6(0.2)0.4, angle(0) labsize(small)) ///
    ymtick(-0.6(0.1)0.4) ytick(-0.6(0.2)0.4) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_race_b_us_nl, replace)

coefplot p_income_c_us p_income_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Income", size(medium)) ///
    ylabel(-0.6(0.2)0.4, angle(0) labsize(small)) ///
    ymtick(-0.6(0.1)0.4) ytick(-0.6(0.2)0.4) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_income_c_us_nl, replace)

coefplot p_class_c_us p_class_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-0.6(0.2)0.4, angle(0) labsize(small)) ///
    ymtick(-0.6(0.1)0.4) ytick(-0.6(0.2)0.4) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_class_c_us_nl, replace)

coefplot p_race_c_us p_race_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-0.6(0.2)0.4, angle(0) labsize(small)) ///
    ymtick(-0.6(0.1)0.4) ytick(-0.6(0.2)0.4) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_race_c_us_nl, replace)

grc1leg p_income_b_us_nl p_class_b_us_nl p_race_b_us_nl ///
        p_income_c_us_nl p_class_c_us_nl p_race_c_us_nl, ///
    legendfrom(p_income_b_us_nl) position(6) row(2) ///
    l1title("Biological racism", size(small)) ///
    l2title("Cultural racism", size(small)) ///
    title("Perceptions of inequality", size(medium))


* ============================================================
* FIGURE 2: Explanations of inequality
* ============================================================

coefplot e_merit_b_us e_merit_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor(blue) lcolor(blue) msymbol(circle)) ///
    p2(mcolor(red)  lcolor(red)  msymbol(square)) ///
    subtitle("Meritocracy", size(medium)) ///
    ylabel(-0.4(0.2)0.6, angle(0) labsize(small)) ///
    ymtick(-0.4(0.1)0.6) ytick(-0.4(0.2)0.6) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "U.S." 2 "Netherlands") pos(6) row(1)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_merit_b_us_nl, replace)

coefplot e_class_b_us e_class_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor(blue) lcolor(blue) msymbol(circle)) ///
    p2(mcolor(red)  lcolor(red)  msymbol(square)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-0.4(0.2)0.6, angle(0) labsize(small)) ///
    ymtick(-0.4(0.1)0.6) ytick(-0.4(0.2)0.6) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_class_b_us_nl, replace)

coefplot e_race_b_us e_race_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor(blue) lcolor(blue) msymbol(circle)) ///
    p2(mcolor(red)  lcolor(red)  msymbol(square)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-0.4(0.2)0.6, angle(0) labsize(small)) ///
    ymtick(-0.4(0.1)0.6) ytick(-0.4(0.2)0.6) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_race_b_us_nl, replace)

coefplot e_merit_c_us e_merit_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor(blue) lcolor(blue) msymbol(circle)) ///
    p2(mcolor(red)  lcolor(red)  msymbol(square)) ///
    subtitle("Meritocracy", size(medium)) ///
    ylabel(-0.4(0.2)0.6, angle(0) labsize(small)) ///
    ymtick(-0.4(0.1)0.6) ytick(-0.4(0.2)0.6) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_merit_c_us_nl, replace)

coefplot e_class_c_us e_class_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor(blue) lcolor(blue) msymbol(circle)) ///
    p2(mcolor(red)  lcolor(red)  msymbol(square)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-0.4(0.2)0.6, angle(0) labsize(small)) ///
    ymtick(-0.4(0.1)0.6) ytick(-0.4(0.2)0.6) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_class_c_us_nl, replace)

coefplot e_race_c_us e_race_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor(blue) lcolor(blue) msymbol(circle)) ///
    p2(mcolor(red)  lcolor(red)  msymbol(square)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-0.4(0.2)0.6, angle(0) labsize(small)) ///
    ymtick(-0.4(0.1)0.6) ytick(-0.4(0.2)0.6) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_race_c_us_nl, replace)

grc1leg e_merit_b_us_nl e_class_b_us_nl e_race_b_us_nl ///
        e_merit_c_us_nl e_class_c_us_nl e_race_c_us_nl, ///
    legendfrom(e_merit_b_us_nl) position(6) row(2) ///
    l1title("Biological racism", size(small)) ///
    l2title("Cultural racism", size(small)) ///
    title("Explanations of inequality", size(medium))


* ============================================================
* FIGURE 3: Attitudes about inequality
* ============================================================

coefplot a_redis_b_us a_redis_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Redistribution", size(medium)) ///
    ylabel(-0.8(0.2)0.2, angle(0) labsize(small)) ///
    ymtick(-0.8(0.1)0.2) ytick(-0.8(0.2)0.2) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "U.S." 2 "Netherlands") pos(6) row(1)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_redis_b_us_nl, replace)

coefplot a_race_b_us a_race_b_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Combat racial discrimination", size(medium)) ///
    ylabel(-0.8(0.2)0.2, angle(0) labsize(small)) ///
    ymtick(-0.8(0.1)0.2) ytick(-0.8(0.2)0.2) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_race_b_us_nl, replace)

coefplot a_redis_c_us a_redis_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Redistribution", size(medium)) ///
    ylabel(-0.8(0.2)0.2, angle(0) labsize(small)) ///
    ymtick(-0.8(0.1)0.2) ytick(-0.8(0.2)0.2) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_redis_c_us_nl, replace)

coefplot a_race_c_us a_race_c_nl, keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    p1(mcolor("$blue") lcolor("$blue") msymbol(circle)) ///
    p2(mcolor("$red")  lcolor("$red")  msymbol(square)) ///
    subtitle("Combat racial discrimination", size(medium)) ///
    ylabel(-0.8(0.2)0.2, angle(0) labsize(small)) ///
    ymtick(-0.8(0.1)0.2) ytick(-0.8(0.2)0.2) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_race_c_us_nl, replace)

grc1leg a_redis_b_us_nl a_race_b_us_nl ///
        a_redis_c_us_nl a_race_c_us_nl, ///
    legendfrom(a_redis_b_us_nl) position(6) row(2) ///
    l1title("Biological racism", size(small)) ///
    l2title("Cultural racism", size(small)) ///
    title("Attitudes about inequality", size(medium))



**********************************************************************************************************************
*sensitivity analysis: test statistically significant difference in median survey completion time by racism category
**********************************************************************************************************************
tab bracialscale //1 Non-racist; 2 Ambiguous; 3 Racist
tab cracialscale

* U.S. — biological racism (non: 10.7, amb: 12.4, rac: 12.4)
forval k = 1/3 {
    sum mins if bracialscale == `k' & country == 1 & sample_us == 1, detail
}
signtest mins = 10.7 if bracialscale == 2 & country == 1 & sample_us == 1   

* U.S. — cultural racism (non: 10.7, amb: 11.7, rac: 11.8)
forval k = 1/3 {
    sum mins if cracialscale == `k' & country == 1 & sample_us == 1, detail
}
signtest mins = 10.7 if cracialscale == 2 & country == 1 & sample_us == 1   

* Netherlands — biological racism (non: 12.1, amb: 12.6, rac: 12.8)
forval k = 1/3 {
    sum mins if bracialscale == `k' & country == 2 & sample_nl == 1, detail
}
signtest mins = 12.1 if bracialscale == 2 & country == 2 & sample_nl == 1   

* Netherlands — cultural racism (non: 11.2, amb: 12.6, rac: 13.3)
forval k = 1/3 {
    sum mins if cracialscale == `k' & country == 2 & sample_nl == 1, detail
}
signtest mins = 11.2 if cracialscale == 2 & country == 2 & sample_nl == 1   



* Pooled (US + NL) — biological racism (non: 11.23, amb: 12.45, rac: 12.35)
forval k = 1/3 {
    sum mins if bracialscale == `k', detail
}
signtest mins = 11.23 if bracialscale == 2   

* Pooled (US + NL) — cultural racism (non: 10.95, amb: 12.08, rac: 12.32)
forval k = 1/3 {
    sum mins if cracialscale == `k', detail
}
signtest mins = 10.95 if cracialscale == 2   



********computing the mode for survey completion by racial beliefs for U.S. and N.L. separately, and for the pooled sample
foreach scale in b c {
    if "`scale'" == "b" local sv bracialscale
    if "`scale'" == "c" local sv cracialscale

    forval k = 1/3 {
        if `k' == 1 local cat non
        if `k' == 2 local cat amb
        if `k' == 3 local cat rac

        * U.S.
        egen modmins_`cat'_`scale'_us = mode(mins) ///
            if `sv' == `k' & country == 1 & sample_us == 1
        tab modmins_`cat'_`scale'_us

        * Netherlands
        egen modmins_`cat'_`scale'_nl = mode(mins) ///
            if `sv' == `k' & country == 2 & sample_nl == 1
        tab modmins_`cat'_`scale'_nl

        * Pooled
        egen modmins_`cat'_`scale'_pooled = mode(mins) if `sv' == `k'
        tab modmins_`cat'_`scale'_pooled
    }
}


***************************************************************************************************
*Sensitivity analysis - OLogit regression - racial beliefs and inequality beliefs
***************************************************************************************************
*U.S. vs N.L.
*perceptions as outcomes, biological as predictor
ologit perception_income i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
outreg2 m1 using ologit_perception_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  

ologit perception_class i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
outreg2 m2 using ologit_perception_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  

ologit perception_race i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m3
outreg2 m3 using ologit_perception_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*perceptions as outcomes, cultural as predictor
ologit perception_income i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m4
outreg2 m4 using ologit_perception_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


ologit perception_class i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m5
outreg2 m5 using ologit_perception_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


ologit perception_race i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m6
outreg2 m6 using ologit_perception_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*explanation as outcomes, biological as predictor
ologit belief_merit_r i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m7
outreg2 m7 using ologit_explanation_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


ologit belief_1 i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m8
outreg2 m8 using ologit_explanation_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


ologit belief_race i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m9
outreg2 m9 using ologit_explanation_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*explanation as outcomes, cultural as predictor
ologit belief_merit_r i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m10
outreg2 m10 using ologit_explanation_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


ologit belief_1 i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m11
outreg2 m11 using ologit_explanation_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


ologit belief_race i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m12
outreg2 m12 using ologit_explanation_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*attitudes as outcomes, biological as predictor
ologit att_redis i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m13
outreg2 m13 using ologit_attitude_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  

ologit att_race i.bracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m14
outreg2 m14 using ologit_attitude_biological.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*attitudes as outcomes, cultural as predictor
ologit att_redis i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m15
outreg2 m15 using ologit_attitude_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)


ologit att_race i.cracialscale##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m16
outreg2 m16 using ologit_attitude_cultural.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  



***************************************************************************************************************
*Coefficients plots presenting AME where biological and cultural racism are measured as categorical variables
***************************************************************************************************************
lab def attitudes_abbre 1 "Strongly disagree" 2 "Disagree" 3 "Somewhat disag." 4 "Nr disag. nor ag." 5 "Somewhat ag." 6 "Agree" 7 "Strongly ag.", replace
lab val bracial attitudes_abbre
lab val racialattitudes3 attitudes_abbre
tab bracial
tab racialattitudes3

set scheme plotplainblind

* ============================================================
* PERCEPTIONS AS OUTCOMES - BIOLOGICAL RACISM AS PREDICTOR
* ============================================================

reg perception_income i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto p_income_b_us
coefplot p_income_b_us, keep(*:)

reg perception_income i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto p_income_b_nl
coefplot p_income_b_nl, keep(*:)

reg perception_class i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto p_class_b_us
coefplot p_class_b_us, keep(*:)

reg perception_class i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto p_class_b_nl
coefplot p_class_b_nl, keep(*:)

reg perception_race i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto p_race_b_us
coefplot p_race_b_us, keep(*:)

reg perception_race i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto p_race_b_nl
coefplot p_race_b_nl, keep(*:)


* ============================================================
* PERCEPTIONS AS OUTCOMES - CULTURAL RACISM AS PREDICTOR
* ============================================================

reg perception_income i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto p_income_c_us
coefplot p_income_c_us, keep(*:)

reg perception_income i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto p_income_c_nl
coefplot p_income_c_nl, keep(*:)

reg perception_class i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto p_class_c_us
coefplot p_class_c_us, keep(*:)

reg perception_class i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto p_class_c_nl
coefplot p_class_c_nl, keep(*:)

reg perception_race i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto p_race_c_us
coefplot p_race_c_us, keep(*:)

reg perception_race i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto p_race_c_nl
coefplot p_race_c_nl, keep(*:)


* ============================================================
* EXPLANATIONS AS OUTCOMES - BIOLOGICAL RACISM AS PREDICTOR
* ============================================================

reg belief_merit i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto e_merit_b_us
coefplot e_merit_b_us, keep(*:)

reg belief_merit i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto e_merit_b_nl
coefplot e_merit_b_nl, keep(*:)

reg belief_1 i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto e_class_b_us
coefplot e_class_b_us, keep(*:)

reg belief_1 i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto e_class_b_nl
coefplot e_class_b_nl, keep(*:)

reg belief_race i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto e_race_b_us
coefplot e_race_b_us, keep(*:)

reg belief_race i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto e_race_b_nl
coefplot e_race_b_nl, keep(*:)


* ============================================================
* EXPLANATIONS AS OUTCOMES - CULTURAL RACISM AS PREDICTOR
* ============================================================

reg belief_merit i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto e_merit_c_us
coefplot e_merit_c_us, keep(*:)

reg belief_merit i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto e_merit_c_nl
coefplot e_merit_c_nl, keep(*:)

reg belief_1 i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto e_class_c_us
coefplot e_class_c_us, keep(*:)

reg belief_1 i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto e_class_c_nl
coefplot e_class_c_nl, keep(*:)

reg belief_race i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto e_race_c_us
coefplot e_race_c_us, keep(*:)

reg belief_race i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto e_race_c_nl
coefplot e_race_c_nl, keep(*:)


* ============================================================
* ATTITUDES AS OUTCOMES - BIOLOGICAL RACISM AS PREDICTOR
* ============================================================

reg att_redis i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto a_redis_b_us
coefplot a_redis_b_us, keep(*:)

reg att_redis i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto a_redis_b_nl
coefplot a_redis_b_nl, keep(*:)

reg att_race i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 1) post
est sto a_race_b_us
coefplot a_race_b_us, keep(*:)

reg att_race i.bracial##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(bracial) at(country = 2) post
est sto a_race_b_nl
coefplot a_race_b_nl, keep(*:)


* ============================================================
* ATTITUDES AS OUTCOMES - CULTURAL RACISM AS PREDICTOR
* ============================================================

reg att_redis i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto a_redis_c_us
coefplot a_redis_c_us, keep(*:)

reg att_redis i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto a_redis_c_nl
coefplot a_redis_c_nl, keep(*:)

reg att_race i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 1) post
est sto a_race_c_us
coefplot a_race_c_us, keep(*:)

reg att_race i.racialattitudes3##i.country i.treatment i.sex_r lgage ///
    i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
margins, dydx(racialattitudes3) at(country = 2) post
est sto a_race_c_nl
coefplot a_race_c_nl, keep(*:)


* ============================================================
* FIGURE 1: Perceptions of inequality
* ============================================================

coefplot (p_income_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (p_income_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Income", size(medium)) ///
    ylabel(-1.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.5) ytick(-1.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "U.S." 2 "Netherlands") pos(6) row(1)) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_income_b_us_nl, replace)

coefplot (p_class_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (p_class_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-1.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.5) ytick(-1.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_class_b_us_nl, replace)

coefplot (p_race_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (p_race_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-1.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.5) ytick(-1.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_race_b_us_nl, replace)

coefplot (p_income_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (p_income_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Income", size(medium)) ///
    ylabel(-1.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.5) ytick(-1.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_income_c_us_nl, replace)

coefplot (p_class_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (p_class_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-1.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.5) ytick(-1.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_class_c_us_nl, replace)

coefplot (p_race_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (p_race_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-1.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.5) ytick(-1.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(p_race_c_us_nl, replace)

grc1leg p_income_b_us_nl p_class_b_us_nl p_race_b_us_nl ///
        p_income_c_us_nl p_class_c_us_nl p_race_c_us_nl, ///
    legendfrom(p_income_b_us_nl) position(6) row(1) ///
    cols(3)   ///
    l1title("Biological racism", size(small)) ///
    l2title("Cultural racism", size(small)) ///
    title("Perceptions of inequality", size(medium)) ///
    imargin(zero) graphregion(margin(l=5 r=0 t=10 b=0))


* ============================================================
* FIGURE 2: Explanations of inequality
* ============================================================

coefplot (e_merit_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (e_merit_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Meritocracy", size(medium)) ///
    ylabel(-0.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-0.5(0.25)1.5) ytick(-0.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "U.S." 2 "Netherlands") pos(6) row(1)) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_merit_b_us_nl, replace)

coefplot (e_class_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (e_class_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-0.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-0.5(0.25)1.5) ytick(-0.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_class_b_us_nl, replace)

coefplot (e_race_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (e_race_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-0.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-0.5(0.25)1.5) ytick(-0.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_race_b_us_nl, replace)

coefplot (e_merit_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (e_merit_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Meritocracy", size(medium)) ///
    ylabel(-0.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-0.5(0.25)1.5) ytick(-0.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_merit_c_us_nl, replace)

coefplot (e_class_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (e_class_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Class", size(medium)) ///
    ylabel(-0.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-0.5(0.25)1.5) ytick(-0.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_class_c_us_nl, replace)

coefplot (e_race_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (e_race_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Race", size(medium)) ///
    ylabel(-0.5(0.5)1.5, angle(0) labsize(small)) ///
    ymtick(-0.5(0.25)1.5) ytick(-0.5(0.5)1.5) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(e_race_c_us_nl, replace)

grc1leg e_merit_b_us_nl e_class_b_us_nl e_race_b_us_nl ///
        e_merit_c_us_nl e_class_c_us_nl e_race_c_us_nl, ///
    legendfrom(e_merit_b_us_nl) position(6) row(1) ///
    cols(3)  ///
    l1title("Biological racism", size(small)) ///
    l2title("Cultural racism", size(small)) ///
    title("Explanations of inequality", size(medium)) ///
    imargin(zero) graphregion(margin(l=5 r=0 t=10 b=0))


* ============================================================
* FIGURE 3: Attitudes about inequality
* ============================================================

coefplot (a_redis_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (a_redis_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Redistribution", size(medium)) ///
    ylabel(-1.5(0.5)1.0, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.0) ytick(-1.5(0.5)1.0) ///
    xlabel(, angle(45) labsize(small)) ///
    legend(order(1 "U.S." 2 "Netherlands") pos(6) row(1)) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_redis_b_us_nl, replace)

coefplot (a_race_b_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (a_race_b_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Combat racial discrimination", size(medium)) ///
    ylabel(-1.5(0.5)1.0, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.0) ytick(-1.5(0.5)1.0) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_race_b_us_nl, replace)

coefplot (a_redis_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (a_redis_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Redistribution", size(medium)) ///
    ylabel(-1.5(0.5)1.0, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.0) ytick(-1.5(0.5)1.0) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_redis_c_us_nl, replace)

coefplot (a_race_c_us, mcolor(blue) ciopts(lcolor(blue)) msymbol(circle)) ///
         (a_race_c_nl, mcolor(red)  ciopts(lcolor(red))  msymbol(square)), ///
    keep(*:) vertical yline(0, lp(dash) lc(pink)) ///
    subtitle("Combat racial discrimination", size(medium)) ///
    ylabel(-1.5(0.5)1.0, angle(0) labsize(small)) ///
    ymtick(-1.5(0.25)1.0) ytick(-1.5(0.5)1.0) ///
    xlabel(, angle(45) labsize(small)) legend(off) ///
    plotregion(margin(l=0 r=10 t=2 b=2)) ///
    graphregion(margin(l=5 r=10 t=2 b=2)) ///
    fysize(100) fxsize(80) ytitle("") ///
    name(a_race_c_us_nl, replace)

grc1leg a_redis_b_us_nl a_race_b_us_nl ///
        a_redis_c_us_nl a_race_c_us_nl, ///
    legendfrom(a_redis_b_us_nl) position(6) row(1) ///
    cols(2) ///
    l1title("Biological racism", size(small)) ///
    l2title("Cultural racism", size(small)) ///
    title("Attitudes about inequality", size(medium)) ///
    imargin(zero) graphregion(margin(l=5 r=0 t=2 b=0))
	
	
***************************************************************************************************************	
*Sensitivity analysis: Run OLS regression including restrictive racial belief measures as predictors
***************************************************************************************************************
*perceptions as outcomes, biological racism as predictor
reg perception_income i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
display "R2 = " e(r2_a)
outreg2 m1 using perception_biological_res.doc, replace alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg perception_class i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
display "R2 = " e(r2_a)
outreg2 m2 using perception_biological_res.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg perception_race i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m3
display "R2 = " e(r2_a)
outreg2 m3 using perception_biological_res.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*perceptions as outcomes, cultural racism as predictor
reg perception_income i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
display "R2 = " e(r2_a)
outreg2 m1 using perception_cultural_res.doc, replace alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg perception_class i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
display "R2 = " e(r2_a)
outreg2 m2 using perception_cultural_res.doc, alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg perception_race i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m3
display "R2 = " e(r2_a)
outreg2 m3 using perception_cultural_res.doc, alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*explanation as outcomes, biological racism as predictor
reg belief_merit i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
display "R2 = " e(r2_a)
outreg2 m1 using explanation_biological_res.doc, replace alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg belief_1 i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
display "R2 = " e(r2_a)
outreg2 m2 using explanation_biological_res.doc, alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg belief_race i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m3
display "R2 = " e(r2_a)
outreg2 m3 using explanation_biological_res.doc, alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*explanation as outcomes, cultural racism as predictor
reg belief_merit i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
display "R2 = " e(r2_a)
outreg2 m1 using explanation_cultural_res.doc, replace alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg belief_1 i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
display "R2 = " e(r2_a)
outreg2 m2 using explanation_cultural_res.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg belief_race i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m3
display "R2 = " e(r2_a)
outreg2 m3 using explanation_cultural_res.doc,  alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*attitudes as outcomes, biological racism as predictor
reg att_redis i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
display "R2 = " e(r2_a)
outreg2 m1 using attitude_biological_res.doc, replace alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg att_race i.bracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
display "R2 = " e(r2_a)
outreg2 m2 using attitude_biological_res.doc, alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


*attitudes as outcomes, cultural racism as predictor
reg att_redis i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m1
display "R2 = " e(r2_a)
outreg2 m1 using attitude_cultural_res.doc, replace alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  


reg att_race i.cracialscale_res_cat3##i.country i.treatment i.sex_r lgage i.whiteyes i.religion i.reliattend i.educat i.hhincomecat3 i.pol5, r
est store m2
display "R2 = " e(r2_a)
outreg2 m2 using attitude_cultural_res.doc, alpha(0.001, 0.01, 0.05, 0.1) dec(3) symbol(***, **, *, †)  

	