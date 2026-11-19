version 16.0
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) type(both) clear
assert _N > 0
local id : char _dta[ilostat_id]
assert "`id'" == "EMP_TEMP_SEX_AGE_NB_A"
local segment : char _dta[ilostat_segment]
assert "`segment'" == "indicator"
local typ : char _dta[ilostat_type]
assert "`typ'" == "both"
local url : char _dta[ilostat_url]
assert strpos("`url'", "channel=ilostat-stata") > 0
ilostat info

tempfile snapshot
save "`snapshot'", replace
clear
use "`snapshot'", clear
local restored : char _dta[ilostat_id]
assert "`restored'" == "EMP_TEMP_SEX_AGE_NB_A"
ilostat info

display as result "PASS: provenance survives save/use"
