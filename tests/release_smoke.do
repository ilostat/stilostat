*! ILOSTAT v0.9.2-rc release smoke test
version 16.0
set more off
capture log close _all
* Run after registering the development directory with adopath ++.
which ilostat

* General dictionary
ilostat dic sex, lang(en) clear
confirm variable sex
confirm variable sex_label
assert _N >= 3

* Dataset-specific dictionary (new feature)
ilostat datasetdic EMP_TEMP_SEX_AGE_NB_A, var(sex) clear
confirm variable code
confirm variable label
assert _N > 0

* Both catalogue segments
ilostat toc, by(indicator) indicator(EMP_TEMP) freq(Q) clear
confirm variable id
assert _N > 0
ilostat toc, by(ref_area) ref_area(FRA) freq(A) lang(fr) clear
confirm variable id
assert _N > 0

* Catalogue metadata
ilostat metadata EMP_TEMP_SEX_AGE_NB_A, clear
assert _N == 1
confirm variable last_update
ilostat metadata FRA_A, by(ref_area) lang(fr) clear
assert _N == 1
confirm variable ref_area
assert id[1] == "FRA_A"
* Verify automatic segment detection separately.
ilostat metadata FRA_A, lang(fr) clear
confirm variable ref_area
assert id[1] == "FRA_A"
assert _N == 1

* Year validation: valid and invalid inputs
* Valid 2020 is exercised by the next retrieval.
capture noisily ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(20A0) clear
assert _rc == 198

* Indicator and reference-area retrieval
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) type(both) clear
assert _N > 0
confirm variable ref_area_label
confirm variable obs_value
ilostat info
ilostat dimensions
local ident : char _dta[ilostat_id]
assert "`ident'" == "EMP_TEMP_SEX_AGE_NB_A"
tempfile saved
save "`saved'"
clear
use "`saved'", clear
local ident2 : char _dta[ilostat_id]
assert "`ident2'" == "EMP_TEMP_SEX_AGE_NB_A"

ilostat get FRA_A, indicator(EMP_TEMP_SEX_AGE_NB) timefrom(2020) clear
assert _N > 0
confirm variable ref_area

* Label parser: quoted commas inside labels
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area_label("France", "Tanzania, United Republic of") type(both) clear
assert _N > 0
assert inlist(ref_area, "FRA", "TZA")

di as result "ILOSTAT v0.9.2-rc release smoke test: PASSED"
