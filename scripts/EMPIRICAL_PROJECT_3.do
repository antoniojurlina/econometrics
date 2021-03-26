. /*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @ Author: Antonio Jurlina		     @
> @ Date: 4/23/2018                  @
> @ Filename: EMPIRICAL_PROJECT_3.do @
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

cls 
clear //clear previous data

cd "E:\UMaine\Spring (2018)\ECO 485\Stata" //setting my directory

// Store results in a log file (diary)
log using "E:\UMaine\Spring (2018)\ECO 485\Stata\Empirical_Project_3", replace text

use CBP_survey.dta //choose data

// following commands represent my data clean-up process
////////////////////////////////////////////////////////////////////

encode Q3, generate(yrs_employed)
replace yrs_employed = 0.5 if Q3 == "Less than 1 year"
replace yrs_employed = 2 if Q3 == "1 to 3 years"
replace yrs_employed = 4 if Q3 == "3 to 5 years"
replace yrs_employed = 7.5 if Q3 == "5 to 10 years"
replace yrs_employed = 15 if Q3 == "More than 10 years"

encode Q4, generate(income)
replace income = 5720 if Q4 == "£0 - £11,440 per year"
replace income = 12480.5 if Q4 == "£11,441 - £13,520 per year"
replace income = 14820.5 if Q4 == "£13,521 - £16,120 per year"
replace income = 17420.5 if Q4 == "£16,121 - £18,720 per year"
replace income = 20540.5 if Q4 == "£18,721 - £22,360 per year"
replace income = 25220.5 if Q4 == "£22,361 - £28,080 per year"
replace income = 31720.5 if Q4 == "£28,081 - £35,360 per year"
replace income = 40300.5 if Q4 == "£35,361 - £45,240 per year"
replace income = 55241 if Q4 == "£45,241 or more per year"

drop if Q5 == "25- 40" | Q5 == "25- 41" | Q5 == "25- 42" | Q5 == "25- 43" 
drop if Q5 == "25- 44" | Q5 == "25- 45" | Q5 == "25- 46" | Q5 == "25- 47" | Q5 == "25- 48" | Q5 == "25- 49"
encode Q5, generate(age)
replace age = 21 if Q5 == "18- 24"
replace age = 32 if Q5 == "25- 39"
replace age = 47 if Q5 == "40- 54"
replace age = 59.5 if Q5 == "55- 64"
replace age = 74 if Q5 == "65"

generate age_sq = age * age

label define sex 1 "Male" 0 "Female"
encode Q6, generate(sex)

generate relationshipy = Q7
replace relationshipy = "Yes" if Q7 == "Co-habiting"
replace relationshipy = "Yes" if Q7 == "Married"
replace relationshipy = "No" if Q7 == "Single"
label define relationship 1 "Yes" 0 "No"
encode relationshipy, generate(relationship)
drop relationshipy Q7

label define children 1 "Yes" 0 "No"
encode Q8, generate(children)

rename Q14h pub_trans_quality
rename Q14i congestion

generate satisfactiony = Q15
label define satisfaction 1 "Satisfied" 0 "Unsatisfied"
encode satisfactiony, generate(satisfaction)
drop satisfactiony Q15

encode Q19, generate(train)
label define education 1 "High School" 2 "Associates degree" 3 "Bachelors Degree BA, BSc" 4 "Masters Degree" 5 "Professional degree" 6 "PhD"
encode Q20, generate(education)

rename Q30c travel_importance
rename Q30f work_travel_ease
rename Q31 life_satisfaction

summarize pub_trans_quality
replace pub_trans_quality = r(mean) if pub_trans_quality == .
summarize congestion
replace congestion = r(mean) if congestion == .
summarize yrs_employed
replace yrs_employed = r(mean) if yrs_employed == .
summarize income
replace income = r(mean) if income == .

summarize age
replace age = r(mean) if age == .
summarize sex
replace sex = r(mean) if sex == .
summarize relationship
replace relationship = r(mean) if relationship == .
summarize satisfaction
replace satisfaction = r(mean) if satisfaction == .
summarize train
drop if train == .
summarize education
replace education = r(mean) if education == .
summarize life_satisfaction
replace life_satisfaction = r(mean) if life_satisfaction == .
summarize children
replace children = r(mean) if children == .
summarize work_travel_ease
replace work_travel_ease = r(mean) if work_travel_ease == .
summarize travel_importance
replace travel_importance = r(mean) if travel_importance == .

generate transport1 = Q16
replace transport1 = "Hippie" if Q16 ==  "Walk" | Q16 == "Cycle"
replace transport1 = "Public" if Q16 == "Train" | Q16 == "Bus"
replace transport1 = "Drive" if Q16 == "Car /Motorcycle"
label define trans1 0 "Hippie" 1 "Public" 2 "Drive"
encode transport1, generate(trans1)
//generate transport2 = Q18
//replace transport2 = "Hippie" if Q18 ==  "Walk" | Q18 == "Cycle"
//replace transport2 = "Public" if Q18 == "Train" | Q18 == "Bus"
//replace transport2 = "Drive" if Q18 == "Car /Motorcycle"
//encode transport2, generate(trans2)

drop if trans1 == .


//generate transporty = Q16
//replace transporty = "Drive" if Q16 == "Car /Motorcycle"
//generate transports = Q18
//replace transports = "Drive" if Q18 == "Car /Motorcycle"
//generate transport = transporty + transports
//replace transport = "Bus" if transport == "BusBus"
//replace transport = "Drive" if transport == "DriveDrive"
//replace transport = "Train" if transport == "TrainTrain"
//replace transport = "Walk" if transport == "WalkWalk"
//replace transport = "Bus / Cycle" if transport == "BusCycle"
//replace transport = "Bus / Cycle" if transport == "CycleBus"
//replace transport = "Bus / Drive" if transport == "BusDrive" & transport == "DriveBus"
//replace transport = "Bus / Drive" if transport == "BusDrive" | transport == "DriveBus"
//replace transport = "Bus / Train" if transport == "BusTrain" | transport == "TrainBus"
//replace transport = "Bus / Walk" if transport == "BusWalk" | transport == "WalkBus"
//replace transport = "Cycle / Drive" if transport == "CycleDrive" | transport == "DriveCycle"
//replace transport = "Cycle / Train" if transport == "CycleTrain" | transport == "TrainCycle"
//replace transport = "Cycle / Walk" if transport == "CycleWalk" | transport == "WalkCycle"
//replace transport = "Cycle / Train" if transport == "Cycletrain"
//replace transport = "Drive / Train" if transport == "DriveTrain" | transport == "TrainDrive"
//replace transport = "Drive / Walk" if transport == "DriveWalk" | transport == "WalkDrive"
//replace transport = "Train / Walk" if transport == "TrainWalk" | transport == "WalkTrain"

//encode transport, generate(transportation)
//drop if transportation == .
//drop transport transporty transports Q16 Q18 

summarize Q28a
replace Q28a = r(mean) if Q28a == .
summarize Q28b
replace Q28b = r(mean) if Q28b == .
summarize Q28c
replace Q28c = r(mean) if Q28c == .
summarize Q28d
replace Q28d = r(mean) if Q28d == .
summarize Q28e
replace Q28e = r(mean) if Q28e == .
summarize Q28f
replace Q28f = r(mean) if Q28f == .
summarize Q28g
replace Q28g = r(mean) if Q28g == .
summarize Q29a
replace Q29a = r(mean) if Q29a == .
summarize Q29b
replace Q29b = r(mean) if Q29b == .
summarize Q29c
replace Q29c = r(mean) if Q29c == .
summarize Q29d
replace Q29d = r(mean) if Q29d == .
summarize Q29e
replace Q29e = r(mean) if Q29e == .
summarize Q29f
replace Q29f = r(mean) if Q29f == .
summarize Q29g
replace Q29g = r(mean) if Q29g == .
summarize Q29h
replace Q29h = r(mean) if Q29h == .
rename Q29c work_proximity
//generate job = (Q28a + Q28b + Q28c + Q28d + Q28e + Q28f + Q28g + Q29a + Q29b + Q29c + Q29d + Q29e + Q29f + Q29g + Q29h)/15
generate job = (Q28a + Q28b + Q28c + Q28d + Q28e + Q28f + Q28g)/7
generate job_satisfaction = job
summarize job
replace job_satisfaction = 1 if job > 3
replace job_satisfaction = 0 if job <= 3

//alpha Q28a-Q29h
alpha Q28a-Q28g

drop Q3 Q4 Q5 Q6 Q8 Q19 Q20
drop Q1 Q2 Q11 Q13 Q12 Q14a Q14b Q14c Q14d Q14e Q14f Q14g Q14j Q14k Q14l Q14m Q14n Q14o 
drop Q17 Q21 Q22 Q23a Q23b Q24 Q25 Q26 Q27 Q28a Q28b Q28c Q28d Q28e Q28f Q28g
drop Q29a Q29b Q29d Q29e Q29f Q29g Q29h Q30a Q30b Q30d Q30e Q30g Q30h Q30i Q30j Q30k
drop Q32 Q33
drop job Q16 Q18 transport1
////////////////////////////////////////////////////////////////////
// end of data clean-up process

summarize

probit job_satisfaction satisfaction pub_trans_quality children congestion life_satisfaction yrs_employed travel_importance work_travel_ease work_proximity income age age_sq sex relationship i.train education i.trans1,robust
//probit job_satisfaction satisfaction pub_trans_quality children congestion life_satisfaction yrs_employed travel_importance work_travel_ease work_proximity income age sex relationship train education trans2,robust
//probit job_satisfaction satisfaction pub_trans_quality children congestion life_satisfaction yrs_employed travel_importance work_travel_ease work_proximity income age sex relationship train education trans1 trans2,robust
//probit job_satisfaction satisfaction pub_trans_quality children congestion life_satisfaction yrs_employed travel_importance work_travel_ease work_proximity income age sex relationship train education,robust
margins, dydx(*)

probit satisfaction job_satisfaction pub_trans_quality children congestion life_satisfaction yrs_employed travel_importance work_travel_ease work_proximity income age age_sq sex relationship i.train education i.trans1,robust
margins, dydx(*)

save CBP_survey_clean.dta, replace
log close
