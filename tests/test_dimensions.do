* Run from Stata Do-file Editor; requires access to public ILOSTAT API.
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

* NOC dataset: do not assume sex/classif1/classif2 exist.
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) type(both) clear
ilostat dimensions
capture confirm variable ref_area
assert _rc == 0

* Classified dataset: known-working filters.
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FR CH) sex(_M _F) classif1(AGE_AGGREGATE_YGE15) type(both) clear
ilostat dimensions
capture confirm variable sex
assert _rc == 0
capture confirm variable classif1
assert _rc == 0
capture confirm variable ref_area_label
assert _rc == 0

* Preserve both API routes.
ilostat get AFG_A, by(ref_area) indicator(UNE_TUNE_SEX_AGE_NB EMP_TEMP_SEX_AGE_NB) classif1(AGE_YTHADULT_Y15-24) timefrom(2010) clear
ilostat dimensions
