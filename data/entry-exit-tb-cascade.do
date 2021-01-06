*Entry and exit interview data from PROSPECT pilot*

*Prospect entry interview data cleaning *
cd ""
capture log close
log using cascade, replace text 
use entry-exit-data, clear

* Descriptive stats by sex *
tab exit sex, row chi
tab sex, sum(age)
tabstat age, by(sex) stat (median min max)
qreg age sex
tab cough sex, row chi
tab sex, sum(cough_days)
tabstat cough_days, by(sex) stat (median min max)
tab sex if cough_days>0, sum(cough_days)
tabstat cough_days if cough_days>0, by(sex) stat (median min max)
qreg cough_days sex if cough_days>0
tab weight_loss sex, row chi
tab fever sex, row chi
tab night_sweats sex, row chi
tab any_symptoms sex, row chi
tab chronic_cough sex, row chi
tab tb_rx sex, row chi
tab tb_rx sex if cough==1, row chi
tab tb_rx_6m sex, row chi
tab tb_rx_6m sex if cough==1, row chi
tab ipt sex, row chi
tab ipt sex if cough==1, row chi

* Descriptive stats by exit interview *
tab sex exit, row chi
tab exit, sum(age)
tabstat age, by(exit) stat (median min max)
qreg age exit
tab cough exit, row chi
tab exit, sum(cough_days)
tabstat cough_days, by(exit) stat (median min max)
tab exit if cough_days>0, sum(cough_days)
tabstat cough_days if cough_days>0, by(exit) stat (median min max)
qreg cough_days exit if cough_days>0
tab weight_loss exit, row chi
tab fever exit, row chi
tab night_sweats exit, row chi
tab any_symptoms exit, row chi
tab chronic_cough exit, row chi
tab tb_rx exit, row chi
tab tb_rx exit if cough==1, row chi
tab tb_rx_6m exit, row chi
tab tb_rx_6m exit if cough==1, row chi
tab ipt exit, row chi
tab ipt exit if cough==1, row chi

* Descriptive stats by exit interview *
tab sex exit, col chi
tab exit, sum(age)
tabstat age, by(exit) stat (median min max)
qreg age exit
tab cough exit, col chi
tab exit, sum(cough_days)
tabstat cough_days, by(exit) stat (median min max)
tab exit if cough_days>0, sum(cough_days)
tabstat cough_days if cough_days>0, by(exit) stat (median min max)
qreg cough_days exit if cough_days>0
tab weight_loss exit, col chi
tab fever exit, col chi
tab night_sweats exit, col chi
tab any_symptoms exit, col chi
tab chronic_cough exit, col chi
tab tb_rx exit, col chi
tab tb_rx exit if cough==1, col chi
tab tb_rx_6m exit, col chi
tab tb_rx_6m exit if cough==1, col chi
tab ipt exit, col chi
tab ipt exit if cough==1, col chi

* Remove if no exit interview *
drop if exit==0

* Remove if on IPT or TB treatment *
codebook ipt
drop if ipt==3
codebook tb_rx
drop if tb_rx==3


* All clients cascade *
tab ask_cgh
tab ask_sput
tab give_sput
tab got_sput_result
tab told_tb
tab start_tb_rx


* Any symptom cascade *
tab any_symptoms ask_cgh, row
tab any_symptoms ask_sput, row
tab any_symptoms give_sput, row
tab any_symptoms got_sput_result, row
tab any_symptoms told_tb, row
tab any_symptoms start_tb_rx, row

tab ask_cgh ask_sput if any_symptoms==1
tab ask_sput give_sput if ask_cgh==1 & any_symptoms==1
tab give_sput got_sput_result if ask_cgh==1 & any_symptoms==1


* Cough cascade *
tab cough ask_cgh, row
tab cough ask_sput, row
tab cough give_sput, row
tab cough got_sput_result, row
tab cough told_tb, row
tab cough start_tb_rx, row

tab ask_cgh ask_sput if cough==1
tab ask_sput give_sput if ask_cgh==1 & cough==1
tab give_sput got_sput_result if ask_cgh==1 & cough==1


* Chronic cough cascade *
tab chronic_cough ask_cgh, row
tab chronic_cough ask_sput, row
tab chronic_cough give_sput, row
tab chronic_cough got_sput_result, row
tab chronic_cough told_tb, row
tab chronic_cough start_tb_rx, row

tab ask_cgh ask_sput if chronic_cough==1
tab ask_sput give_sput if ask_cgh==1 & chronic_cough==1
tab give_sput got_sput_result if ask_cgh==1 & chronic_cough==1


* HIV+ cascade *
tab hivstatus ask_cgh, row
tab hivstatus ask_sput, row
tab hivstatus give_sput, row
tab hivstatus got_sput_result, row
tab hivstatus told_tb, row
tab hivstatus start_tb_rx, row

tab ask_cgh ask_sput if hivstatus==3
tab ask_sput give_sput if ask_cgh==1 & hivstatus==3
tab give_sput got_sput_result if ask_cgh==1 & hivstatus==3


* HIV+ & cough cascade *
tab cough ask_cgh if hivstatus==3, row 
tab cough ask_sput if hivstatus==3, row
tab cough give_sput if hivstatus==3, row
tab cough got_sput_result if hivstatus==3, row
tab cough told_tb if hivstatus==3, row
tab cough start_tb_rx if hivstatus==3, row

tab ask_cgh ask_sput if hivstatus==3 & cough==1
tab ask_sput give_sput if ask_cgh==1 & hivstatus==3 & cough==1
tab give_sput got_sput_result if ask_cgh==1 & hivstatus==3 & cough==1


* HIV+ & any TB symptom cascade *
tab ask_cgh if hivstatus==3 & any_symptom==1
tab ask_cgh ask_sput if hivstatus==3 & any_symptom==1
tab ask_sput give_sput if hivstatus==3 & any_symptom==1
tab give_sput got_sput_result if hivstatus==3 & any_symptom==1

tab ask_cgh ask_sput if hivstatus==3 & any_symptom==1
tab ask_cgh give_sput if hivstatus==3 & any_symptom==1

* HIV- & Chronic cough cascade *
tab ask_cgh if hivstatus==1 & chronic_cough==1
tab ask_cgh ask_sput if hivstatus==1 & chronic_cough==1
tab ask_sput give_sput if hivstatus==1 & chronic_cough==1
tab give_sput got_sput_result if hivstatus==1 & chronic_cough==1

tab ask_cgh if hivstatus==1 & chronic_cough==1
tab ask_cgh ask_sput if hivstatus==1 & chronic_cough==1
tab ask_sput give_sput if ask_cgh==1 & hivstatus==1 & chronic_cough==1
tab give_sput got_sput_result if ask_cgh==1 & hivstatus==1 & chronic_cough==1


* HIV- ,Chronic cough & weight loss cascade *
tab ask_cgh if hivstatus==1 & (chronic_cough==1 | weight_loss==1)
tab ask_cgh ask_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1)
tab ask_sput give_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1)
tab give_sput got_sput_result if hivstatus==1 & (chronic_cough==1 | weight_loss==1)

tab ask_cgh ask_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1)
tab ask_cgh give_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1)


* HIV- ,Chronic cough & all other symptoms cascade *
tab ask_cgh if hivstatus==1 & (chronic_cough==1 | weight_loss==1 | night_sweats==1 | fever==1)
tab ask_cgh ask_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1 | night_sweats==1 | fever==1)
tab ask_sput give_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1 | night_sweats==1 | fever==1)
tab give_sput got_sput_result if hivstatus==1 & (chronic_cough==1 | weight_loss==1 | night_sweats==1 | fever==1)

tab ask_cgh ask_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1 | night_sweats==1 | fever==1)
tab ask_cgh give_sput if hivstatus==1 & (chronic_cough==1 | weight_loss==1 | night_sweats==1 | fever==1)

* HIV unknown & any TB symptom cascade *
tab ask_cgh if hivstatus==2 & any_symptom==1
tab ask_cgh ask_sput if hivstatus==2 & any_symptom==1
tab ask_sput give_sput if hivstatus==2 & any_symptom==1
tab give_sput got_sput_result if hivstatus==2 & any_symptom==1

* Any HIV status & any TB symptom cascade *
tab ask_cgh if any_symptom==1
tab ask_cgh ask_sput if any_symptom==1
tab ask_sput give_sput if any_symptom==1
tab give_sput got_sput_result if any_symptom==1

* HIV- & any TB symptom cascade *
tab ask_cgh if hivstatus==1 & any_symptom==1
tab ask_cgh ask_sput if hivstatus==1 & any_symptom==1
tab ask_sput give_sput if hivstatus==1 & any_symptom==1
tab give_sput got_sput_result if hivstatus==1 & any_symptom==1

* Identify those asked re sputum but not cough *
tab ask_cgh ask_sput
tab ask_cgh ask_sput if any_symptoms==1
tab ask_cgh ask_sput if cough==1
tab ask_cgh ask_sput if hivstatus==3
tab ask_cgh ask_sput if chronic_cough==1
tab ask_cgh ask_sput if hivstatus==3 & cough==1
tab ask_cgh ask_sput if chronic_cough==1 & hivstatus==1
table ask_sput ask_cgh any_symptoms if hivstatus==3

*Those asked to submit but not clinically indicated*
gen total_symptoms=cough+fever+night_sweats+weight_loss
tab ask_sput hivstatus
tab ask_sput any_symptoms if hivstatus==2
tab ask_sput total_symptoms if hivstatus==2

tab ask_sput any_symptoms if hivstatus==3

tab ask_sput any_symptoms if hivstatus==1 & chronic_cough==0 & weight_loss==0
tab ask_sput any_symptoms if hivstatus==1 & chronic_cough==0 & weight_loss==0 & fever==0 & night_sweats==0
tab ask_sput any_symptoms if hivstatus==1 & chronic_cough==0 & weight_loss==0 & (fever==1 | night_sweats==1)
tab ask_sput cough if hivstatus==1 & chronic_cough==0 & weight_loss==0 & (fever==1 | night_sweats==1)


*Univariable and multivariable analysis*

* Generate cough<2 weeks variable*
gen short_cough=cough_days
recode short_cough 2/13=1
recode short_cough 14/750=0
lab value short_cough YN
codebook short_cough

gen cough_status=cough_days
recode cough_status 2/13=1 14/750=2
label define cough 0 None 1 "<2weeks" 2 "Chronic"
lab value cough_status cough
codebook cough_status

* Descriptive stats - by HIV status *
tab sex hivstatus, row chi
tab hivstatus, sum(age)
tabstat age, by(hivstatus) stat (median min max)
qreg age hivstatus
tab cough hivstatus, row chi
tab hivstatus, sum(cough_days)
tabstat cough_days, by(hivstatus) stat (median min max)
tab hivstatus if cough_days>0, sum(cough_days)
tabstat cough_days if cough_days>0, by(hivstatus) stat (median min max)
qreg cough_days hivstatus if cough_days>0
tab weight_loss hivstatus, row chi
tab fever hivstatus, row chi
tab night_sweats hivstatus, row chi
tab any_symptoms hivstatus, row chi
tab chronic_cough hivstatus, row chi
tab short_cough hivstatus, row chi
tab cough_status hivstatus, row chi
tab tb_rx hivstatus, row chi
tab tb_rx hivstatus if cough==1, row chi
tab tb_rx_6m hivstatus, row exact
tab tb_rx_6m hivstatus if cough==1, row chi
tab ipt hivstatus, row chi
tab ipt hivstatus if cough==1, row chi
tab prevtb hivstatus, row chi
tab art hivstatus, row chi
tab srh hivstatus, row chi

* Descriptive stats - by HIV status *
tab sex hivstatus, col chi
tab hivstatus, sum(age)
tabstat age, by(hivstatus) stat (median min max)
qreg age hivstatus
tab cough hivstatus, col chi
tab hivstatus, sum(cough_days)
tabstat cough_days, by(hivstatus) stat (median min max)
tab hivstatus if cough_days>0, sum(cough_days)
tabstat cough_days if cough_days>0, by(hivstatus) stat (median min max)
qreg cough_days hivstatus if cough_days>0
tab weight_loss hivstatus, col chi
tab fever hivstatus, col chi
tab night_sweats hivstatus, col chi
tab any_symptoms hivstatus, col chi
tab chronic_cough hivstatus, col chi
tab short_cough hivstatus, col chi
tab cough_status hivstatus, col chi
tab tb_rx hivstatus, col chi
tab tb_rx hivstatus if cough==1, col chi
tab tb_rx_6m hivstatus, col exact
tab tb_rx_6m hivstatus if cough==1, col chi
tab ipt hivstatus, col chi
tab ipt hivstatus if cough==1, col chi
tab prevtb hivstatus, col chi
tab art hivstatus, col chi
tab srh hivstatus, col chi

* Descriptive stats - by whether asked to give sputum *
tab sex ask_sput, row chi
tab ask_sput, sum(age)
tabstat age, by(ask_sput) stat (median min max)
qreg age ask_sput
tab cough ask_sput, row chi
tab ask_sput, sum(cough_days)
tabstat cough_days, by(ask_sput) stat (median min max)
tab ask_sput if cough_days>0, sum(cough_days)
tabstat cough_days if cough_days>0, by(ask_sput) stat (median min max)
qreg cough_days ask_sput if cough_days>0
tab weight_loss ask_sput, row chi
tab fever ask_sput, row chi
tab night_sweats ask_sput, row chi
tab any_symptoms ask_sput, row chi
tab chronic_cough ask_sput, row chi
tab short_cough ask_sput, row chi
tab cough_status ask_sput, row chi
tab tb_rx ask_sput, row chi
tab tb_rx ask_sput if cough==1, row chi
tab tb_rx_6m ask_sput, row exact
tab tb_rx_6m ask_sput if cough==1, row chi
tab ipt ask_sput, row chi
tab ipt ask_sput if cough==1, row chi
tab hivstatus ask_sput, row chi
tab prevtb ask_sput, row chi
tab art ask_sput, row chi
tab srh ask_sput, row exact


* Associated factors *
tab sex ask_sput, row chi
tabodds ask_sput sex
mhodds sex ask_sput
summ age, detail
hist age, fraction normal
ranksum age, by(ask_sput)
tab cough ask_sput, row chi
tabodds ask_sput cough
mhodds ask_sput cough
summ cough_days if cough_days>0, detail
hist cough_days if cough_days>0, fraction normal
ranksum cough_days, by(ask_sput)
tab weight_loss ask_sput, row chi
tabodds ask_sput weight_loss
mhodds ask_sput weight_loss
tab fever ask_sput, row chi
tabodds ask_sput fever
mhodds ask_sput fever
tab night_sweats ask_sput, row chi
tabodds ask_sput night_sweats
mhodds ask_sput night_sweats
tab any_symptoms ask_sput, row chi
tabodds ask_sput any_symptoms
mhodds ask_sput any_symptoms
tab chronic_cough ask_sput, row chi
tabodds ask_sput chronic_cough
mhodds ask_sput chronic_cough
tabodds ask_sput short_cough
mhodds ask_sput short_cough
tabodds ask_sput cough_status
mhodds ask_sput cough_status
mhodds ask_sput any_symptoms
tab prevtb ask_sput, row chi
tabodds ask_sput prevtb
mhodds ask_sput prevtb
tab art ask_sput, row chi
tabodds ask_sput art
mhodds ask_sput art
tab hivstatus ask_sput, row chi
tabodds ask_sput hivstatus
mhodds ask_sput hivstatus
mhodds ask_sput hivstatus, c(2,1)
mhodds ask_sput hivstatus, c(3,1)

* Associated factors - HIV negative *
tab sex ask_sput if hivstatus==1, row chi 
tabodds ask_sput sex if hivstatus==1
mhodds sex ask_sput if hivstatus==1
summ age if hivstatus==1, detail 
hist age if hivstatus==1, fraction normal
ranksum age if hivstatus==1, by(ask_sput)
tab cough ask_sput if hivstatus==1, row chi
tabodds ask_sput cough if hivstatus==1
mhodds ask_sput cough if hivstatus==1
summ cough_days if cough_days>0 & hivstatus==1, detail
hist cough_days if cough_days>0 & hivstatus==1, fraction normal
ranksum cough_days if hivstatus==1, by(ask_sput)
tab weight_loss ask_sput if hivstatus==1, row chi
tabodds ask_sput weight_loss if hivstatus==1
mhodds ask_sput weight_loss if hivstatus==1
tab fever ask_sput if hivstatus==1, row chi
tabodds ask_sput fever if hivstatus==1
mhodds ask_sput fever if hivstatus==1
tab night_sweats ask_sput if hivstatus==1, row chi
tabodds ask_sput night_sweats if hivstatus==1
mhodds ask_sput night_sweats if hivstatus==1
tab any_symptoms ask_sput if hivstatus==1, row chi
tabodds ask_sput any_symptoms if hivstatus==1
mhodds ask_sput any_symptoms if hivstatus==1
tab chronic_cough ask_sput if hivstatus==1, row chi
tabodds ask_sput chronic_cough if hivstatus==1
mhodds ask_sput chronic_cough if hivstatus==1
tabodds ask_sput short_cough if hivstatus==1
mhodds ask_sput short_cough if hivstatus==1
tabodds ask_sput cough_status if hivstatus==1
mhodds ask_sput cough_status if hivstatus==1
tab prevtb ask_sput if hivstatus==1, row chi
tabodds ask_sput prevtb if hivstatus==1
mhodds ask_sput prevtb if hivstatus==1
tab art ask_sput if hivstatus==1, row chi
tabodds ask_sput art if hivstatus==1
mhodds ask_sput art if hivstatus==1

* Associated factors - HIV positive *
tab sex ask_sput if hivstatus==3, row chi 
tabodds ask_sput sex if hivstatus==3
mhodds sex ask_sput if hivstatus==3
summ age if hivstatus==3, detail 
hist age if hivstatus==3, fraction normal
ranksum age if hivstatus==3, by(ask_sput)
tab cough ask_sput if hivstatus==3, row chi
tabodds ask_sput cough if hivstatus==3
mhodds ask_sput cough if hivstatus==3
summ cough_days if cough_days>0 & hivstatus==3, detail
hist cough_days if cough_days>0 & hivstatus==3, fraction normal
ranksum cough_days if hivstatus==3, by(ask_sput)
tab weight_loss ask_sput if hivstatus==3, row chi
tabodds ask_sput weight_loss if hivstatus==3
mhodds ask_sput weight_loss if hivstatus==3
tab fever ask_sput if hivstatus==3, row chi
tabodds ask_sput fever if hivstatus==3
mhodds ask_sput fever if hivstatus==3
tab night_sweats ask_sput if hivstatus==3, row chi
tabodds ask_sput night_sweats if hivstatus==3
mhodds ask_sput night_sweats if hivstatus==3
tab any_symptoms ask_sput if hivstatus==3, row chi
tabodds ask_sput any_symptoms if hivstatus==3
mhodds ask_sput any_symptoms if hivstatus==3
tab chronic_cough ask_sput if hivstatus==3, row chi
tabodds ask_sput chronic_cough if hivstatus==3
mhodds ask_sput chronic_cough if hivstatus==3
tabodds ask_sput short_cough if hivstatus==3
mhodds ask_sput short_cough if hivstatus==3
tabodds ask_sput cough_status if hivstatus==3
mhodds ask_sput cough_status if hivstatus==3
tab prevtb ask_sput if hivstatus==3, row chi
tabodds ask_sput prevtb if hivstatus==3
mhodds ask_sput prevtb if hivstatus==3
tab art ask_sput if hivstatus==3, row chi
tabodds ask_sput art if hivstatus==3
mhodds ask_sput art if hivstatus==3

* Logistic regression - all *
xi: logistic ask_sput sex age any_symptoms prevtb i.hivstatus
xi: logistic ask_sput sex age cough weight_loss fever night_sweats prevtb i.hivstatus
xi: logistic ask_sput sex age chronic_cough weight_loss fever night_sweats prevtb i.hivstatus
xi: logistic ask_sput sex age short_cough chronic_cough weight_loss fever night_sweats prevtb i.hivstatus
xi: logistic ask_sput sex age cough_status weight_loss fever night_sweats prevtb i.hivstatus
xi: logistic ask_sput sex age cough_days weight_loss fever night_sweats prevtb i.hivstatus

* Logistic regression - HIV negative *
xi: logistic ask_sput sex age any_symptoms prevtb if hivstatus==1
xi: logistic ask_sput sex age cough weight_loss fever night_sweats prevtb if hivstatus==1
xi: logistic ask_sput sex age chronic_cough weight_loss fever night_sweats prevtb if hivstatus==1
xi: logistic ask_sput sex age short_cough chronic_cough weight_loss fever night_sweats prevtb if hivstatus==1

* Logistic regression - HIV positive *
xi: logistic ask_sput sex age any_symptoms prevtb if hivstatus==3
xi: logistic ask_sput sex age cough weight_loss fever night_sweats prevtb if hivstatus==3
xi: logistic ask_sput sex age chronic_cough weight_loss fever night_sweats prevtb if hivstatus==3
xi: logistic ask_sput sex age short_cough chronic_cough weight_loss fever night_sweats prevtb if hivstatus==3
xi: logistic ask_sput sex age any_symptoms prevtb if hivstatus==3

* Plot probability of asking re sputum by age *
probit ask_sput age sex any_symptoms prevtb
margins, at(age=(18(2)90))
marginsplot, recast(line) recastci(rarea)

probit ask_sput age sex any_symptoms prevtb if hivstatus==1
margins, at(age=(18(2)90))
marginsplot, recast(line) recastci(rarea)

probit ask_sput age sex any_symptoms prevtb if hivstatus==3
margins, at(age=(18(2)90))
marginsplot, recast(line) recastci(rarea)

probit ask_sput age sex any_symptoms prevtb i.hivstatus
margins hivstatus, at(age=(18(2)90))
marginsplot, recast(line) recastci(rarea)

probit ask_sput age sex cough weight_loss fever night_sweats prevtb
margins, at(age=(18(2)90))
marginsplot, recast(line) recastci(rarea)

probit ask_sput age sex chronic_cough weight_loss fever night_sweats prevtb
margins, at(age=(18(2)90))
marginsplot, recast(line) recastci(rarea)


* Graph of logistic regression models *
quietly xi: logistic ask_sput sex age any_symptoms prevtb i.hivstatus
estimates store All
quietly xi: logistic ask_sput sex age any_symptoms prevtb if hivstatus==1
estimates store HIV_negative
quietly xi: logistic ask_sput sex age any_symptoms prevtb if hivstatus==3
estimates store HIV_positive
coefplot (All) (HIV_negative, label(HIV-)) (HIV_positive, label(HIV+)), coeflabels (sex="Female" age="Age (years)" any_symptoms="Any TB symptoms" prevtb="Previous TB") eform drop(_cons _Ihivstatus_2 _Ihivstatus_3) xline(1, lwidth(thin) lpattern(dash)) title("Any TB Symptom models") xtitle("Odds ratio")

estimates clear
quietly xi: logistic ask_sput sex age cough weight_loss fever night_sweats prevtb i.hivstatus
estimates store All
quietly xi: xi: logistic ask_sput sex age cough weight_loss fever night_sweats prevtb if hivstatus==1
estimates store HIV_negative
quietly xi: logistic ask_sput sex age cough weight_loss fever night_sweats prevtb if hivstatus==3
estimates store HIV_positive
coefplot (All) (HIV_negative, label(HIV-)) (HIV_positive, label(HIV+)), coeflabels (sex="Female" age="Age (years)" cough="Cough" weight_loss="Weight loss" fever="Fever" night_sweats="Night sweats" prevtb="Previous TB") eform drop(_cons _Ihivstatus_2 _Ihivstatus_3) xline(1, lwidth(thin) lpattern(dash)) title("Individual symptoms: cough models") xtitle("Odds ratio")

estimates clear
quietly xi: logistic ask_sput sex age chronic_cough weight_loss fever night_sweats prevtb i.hivstatus
estimates store All
quietly xi: xi: logistic ask_sput sex age chronic_cough weight_loss fever night_sweats prevtb if hivstatus==1
estimates store HIV_negative
quietly xi: logistic ask_sput sex age chronic_cough weight_loss fever night_sweats prevtb if hivstatus==3
estimates store HIV_positive
coefplot (All) (HIV_negative, label(HIV-)) (HIV_positive, label(HIV+)), coeflabels (sex="Female" age="Age (years)" chronic_cough="Chronic Cough" weight_loss="Weight loss" fever="Fever" night_sweats="Night sweats" prevtb="Previous TB") eform drop(_cons _Ihivstatus_2 _Ihivstatus_3) xline(1, lwidth(thin) lpattern(dash)) title("Individual symptoms: chronic cough models") xtitle("Odds ratio")


* Age by standard deviation instead of year *
egen agesd = sd (age)
egen agemean = mean (age)
gen sd_age = (age-agemean)/agesd

probit ask_sput sd_age sex any_symptoms prevtb
margins, at(sd_age=(-1.5(1)4.5))
marginsplot, recast(line) recastci(rarea)

estimates clear
quietly xi: logistic ask_sput sex sd_age any_symptoms prevtb i.hivstatus
estimates store All
quietly xi: logistic ask_sput sex sd_age any_symptoms prevtb if hivstatus==1
estimates store HIV_negative
quietly xi: logistic ask_sput sex sd_age any_symptoms prevtb if hivstatus==3
estimates store HIV_positive
coefplot (All) (HIV_negative, label(HIV-)) (HIV_positive, label(HIV+)), coeflabels (sex="Female" sd_age="Age (standard deviation)" any_symptoms="Any TB symptoms" prevtb="Previous TB") eform drop(_cons _Ihivstatus_2 _Ihivstatus_3) xline(1, lwidth(thin) lpattern(dash)) title("Any TB Symptom models") xtitle("Odds ratio")
