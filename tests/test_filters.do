* Run from Stata Do-file Editor. Uses the live ILOSTAT API.
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

* Confirm type(both) returns code and label columns in native DTA.
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) type(both) clear
capture confirm variable ref_area_label
assert _rc == 0
count

* Confirm multiple indicators on the reference-area endpoint.
ilostat get AFG_A, by(ref_area) ///
    indicator(UNE_TUNE_SEX_AGE_NB EMP_TEMP_SEX_AGE_NB) ///
    classif1(AGE_YTHADULT_Y15-24) timefrom(2010) type(code) clear
count

* Inspect multi-value/partial filters. Their exact semantics are server-defined.
ilostat get EMP_TEMP_SEX_AGE_NB_A, ///
    ref_area(FR CH) sex(_M _F) ///
    classif1(AGE_AGGREGATE_YGE15) type(both) clear
count
capture noisily tab ref_area
capture noisily tab sex
