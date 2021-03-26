. /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @ Authors: Antonio J, Joe R, Jacob W.   @
> @ Date: 4/5/2018                        @
> @ Filename: EMPIRICAL_PROJECT_2.do      @
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

clear //clear previous data

cd "D:\UMaine\Spring (2018)\ECO 485\Stata" //setting my directory

// Store results in a log file (diary)
log using "D:\UMaine\Spring (2018)\ECO 485\Stata\Empirical_Project_2", replace text

use UMaine_GPA.dta //choose data

// following commands represent our data clean-up process
drop u1 u2 u3 u4 u5 u6 u7 u8
drop drive bike walk sibling
misstable summarize

summarize romantic
replace romantic = r(mean) if romantic == .

generate job19_clean = job19
generate job20_clean = job20
drop if job19 == . & job20 == .
summarize job19_clean
replace job19_clean = r(mean) if job19_clean == .

generate mothcoll_clean = mothcoll
summarize mothcoll_clean
replace mothcoll_clean = r(mean) if mothcoll_clean == .
generate fathcoll_clean = fathcoll
summarize fathcoll_clean
replace fathcoll_clean = r(mean) if fathcoll_clean == .

generate majory = "business"
replace majory = "other" if business == 0
label define major 1 "business" 0 "other"
encode majory, generate(major)
drop majory



summarize age soph junior senior senior5 male // basic data summary

save UMaine_GPA_clean.dta, replace
log close
