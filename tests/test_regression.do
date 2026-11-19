* Smoke/regression suite for v0.9.0; live API required.
version 16.0
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) type(both) clear
confirm variable obs_value
confirm variable ref_area_label
assert _N > 0
ilostat info

ilostat get FRA_A, indicator(EMP_TEMP_SEX_AGE_NB) timefrom(2020) clear
confirm variable obs_value
assert _N > 0

ilostat toc, by(indicator) lang(es) clear
confirm variable indicator_label
assert _N > 0

ilostat toc, by(ref_area) lang(fr) clear
confirm variable ref_area_label
assert _N > 0

ilostat dic sex, lang(en) clear
confirm variable sex
confirm variable sex_label
assert _N > 0

ilostat metadata EMP_TEMP_SEX_AGE_NB_A, clear
confirm variable last_update
assert _N == 1

ilostat datasetdic EMP_TEMP_SEX_AGE_NB_A, var(sex) clear
confirm variable code
confirm variable label
assert _N > 0
