version 19.0
clear all
set more off

* Benchmark direct HTTP retrieval and local import, not the ilostat ado wrapper.
* Run from Stata's Do-file Editor. No production files are modified.
local base "https://rplumber.ilo.org"
local indicator "SDG_0552_NOC_RT_A"
local area "AFG_A"
local repetitions 3

capture log close _all
log using "stilostat_format_benchmark.log", text replace name(bench)

foreach route in indicator ref_area {
    foreach typ in code both {
        foreach fmt in csv dta {
            forvalues run = 1/`repetitions' {
                if "`route'" == "indicator" {
                    local url "`base'/data/indicator?id=`indicator'&timefrom=2015&type=`typ'&format=.`fmt'"
                }
                else {
                    local url "`base'/data/ref_area?id=`area'&indicator=UNE_TUNE_SEX_AGE_NB+EMP_TEMP_SEX_AGE_NB&classif1=AGE_YTHADULT_Y15-24&timefrom=2010&type=`typ'&format=.`fmt'"
                }
                tempfile downloaded
                local path "`downloaded'.`fmt'"
                quietly timer clear 1
                quietly timer clear 2
                timer on 1
                capture noisily copy "`url'" "`path'", replace
                local download_rc = _rc
                timer off 1
                quietly timer list 1
                local transfer = r(t1)
                if `download_rc' {
                    display as error "FAILED download route=`route' type=`typ' format=`fmt' run=`run' rc=`download_rc'"
                    continue
                }
                clear
                timer on 2
                if "`fmt'" == "dta" {
                    capture noisily use "`path'", clear
                }
                else {
                    capture noisily import delimited using "`path'", clear varnames(1) encoding(UTF-8)
                }
                local import_rc = _rc
                timer off 2
                quietly timer list 2
                local importing = r(t2)
                if `import_rc' {
                    display as error "FAILED import route=`route' type=`typ' format=`fmt' run=`run' rc=`import_rc'"
                    continue
                }
                local nobs = _N
                local nvars = c(k)
                display as result "RESULT route=`route' type=`typ' format=`fmt' run=`run' transfer_s=" %9.3f `transfer' " import_s=" %9.3f `importing' " obs=" %12.0f `nobs' " vars=" %6.0f `nvars'
                capture confirm variable ref_area_label
                local underscore = (_rc == 0)
                capture confirm variable ref_area_label
                display as text "LABEL_COLUMN ref_area_label_present=`underscore'"
            }
        }
    }
}
log close bench
