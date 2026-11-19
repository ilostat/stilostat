version 16
* Run after adopath ++ "H:/_Sys/packages/stilostat"
which ilostat
capture noisily ilostat get SDG_0552_NOC_RT_A, timefrom(2015) clear
local rc1 = _rc
di "Indicator DTA test return code: `rc1'"
if `rc1' == 0 describe
capture noisily ilostat get AFG_A, by(ref_area) ///
    indicator(UNE_TUNE_SEX_AGE_NB EMP_TEMP_SEX_AGE_NB) ///
    classif1(AGE_YTHADULT_Y15-24) timefrom(2010) format(csv) clear
local rc2 = _rc
di "Reference-area CSV test return code: `rc2'"
if `rc2' == 0 describe
