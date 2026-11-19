* Run in Stata Do-file Editor; requires network access.
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
clear
ilostat metadata EMP_TEMP_SEX_AGE_NB_A, clear
assert _N == 1
assert id[1] == "EMP_TEMP_SEX_AGE_NB_A"
clear
ilostat metadata FRA_A, lang(fr) clear
assert _N == 1
assert id[1] == "FRA_A"
* Verify existing retrieval still works.
clear
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) clear
assert _N > 0
