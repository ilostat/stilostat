adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) type(both) headers clear
ilostat info
char list _dta[]
