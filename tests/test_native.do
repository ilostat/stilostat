version 16.0
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) type(both) clear
assert _N > 0
confirm variable ref_area_label
ilostat info

ilostat dic sex, lang(en) clear
confirm variable sex
confirm variable sex_label

ilostat toc, indicator(EMP_TEMP) freq(Q) clear
assert _N > 0

display as result "ILOSTAT native transport smoke test passed"
