* stilostat 0.7.2 segment smoke tests. Run in Stata do-file editor.
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

* Small filtered requests, avoid full reference-area downloads.
ilostat get FRA_A, indicator(EMP_TEMP_SEX_AGE_NB) timefrom(2020) clear
assert _N > 0
local route : char _dta[ilostat_route]
assert "`route'" == "ref_area"

ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) clear
assert _N > 0
local route : char _dta[ilostat_route]
assert "`route'" == "indicator"

ilostat get FRA_A, by(ref_area) indicator(EMP_TEMP_SEX_AGE_NB) timefrom(2020) clear
assert _N > 0

ilostat toc, by(ref_area) ref_area(FRA) freq(A) lang(fr) clear
assert _N > 0
assert ref_area == "FRA" if !missing(ref_area)
assert freq == "A" if !missing(freq)
