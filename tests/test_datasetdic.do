* Run from Stata Do-file Editor. Network requests: 4 small metadata requests.
version 16.0
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

ilostat datasetdic EMP_TEMP_SEX_AGE_NB_A, var(sex) clear
confirm variable code
confirm variable label
assert _N > 0
list in 1/4

ilostat datasetdic FRA_A, var(indicator) lang(fr) clear
confirm variable code
confirm variable label
assert _N > 0

ilostat datasetdic CLD_XCHL_SEX_AGE_ECO_NB_A, var(classif2) code(AGR) clear
confirm variable code
confirm variable label

ilostat datasetdic EMP_TEMP_SEX_AGE_NB_A, var(sex) code(SEX_M) match(exact) clear
confirm variable code
assert _N > 0
assert code == "SEX_M"
