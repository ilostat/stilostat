* Stata/MP 19 - run from Do-file Editor
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

* NOC: must not require sex/classif1/classif2
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) type(both) clear
ilostat dimensions

* Filter a small country-specific subset using a label
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(DOM) ref_area_label("Dominican") type(both) clear
count
describe

* Multiple label alternatives; test only after first two pass
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(DOM CHE) ref_area_label(`" "Dominican" "Switzerland" "') type(both) clear
tab ref_area
