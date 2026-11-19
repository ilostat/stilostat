version 16.0
set more off

* Benchmark only: does not modify ilostat.ado.
* Run from Stata Do-file Editor. Change outputdir if desired.
local outputdir "H:/_Sys/packages/stilostat/tests/benchmark"
local repeats 2
local dataset "EMP_TEMP_SEX_AGE_ECO_NB_Q"
local base "https://rplumber.ilo.org/data/indicator"

capture mkdir "`outputdir'"
local results "`outputdir'/large_format_results.csv"
local logpath "`outputdir'/large_format_benchmark.log"
capture log close largebench
log using "`logpath'", text replace name(largebench)

* No warm-up on the large dataset: avoid an additional expensive API request.
* Four scenarios x repeats (default: 8 production requests). Do not run concurrently.
file open out using "`results'", write text replace
file write out "dataset,type,format,run,download_seconds,import_seconds,total_seconds,bytes,obs,vars,obs_value_sum,obs_value_missing,ref_area_label_present,rc" _n

foreach typ in code both {
    foreach fmt in csv dta {
        forvalues run=1/`repeats' {
            local url "`base'?id=`dataset'&type=`typ'&format=.`fmt'"
            tempfile payload
            local path "`payload'.`fmt'"
            local dl = .
            local imp = .
            local bytes = .
            local nobs = .
            local nvars = .
            local value_sum = .
            local value_missing = .
            local haslabel = 0
            local rc = 0

            timer clear 1
            timer clear 2
            timer on 1
            capture quietly copy "`url'" "`path'", replace
            local rc = _rc
            timer off 1
            quietly timer list 1
            local dl = r(t1)

            if `rc' == 0 {
                * File size via Stata binary file positioning (no external dependency).
                capture file open fsize using "`path'", read binary
                if _rc == 0 {
                    capture file seek fsize eof
                    if _rc == 0 {
                        quietly file query fsize
                        local bytes = r(loc)
                    }
                    file close fsize
                }

                timer on 2
                if "`fmt'" == "dta" {
                    capture quietly use "`path'", clear
                }
                else {
                    capture quietly import delimited using "`path'", clear varnames(1) encoding("UTF-8")
                }
                local rc = _rc
                timer off 2
                quietly timer list 2
                local imp = r(t2)
            }

            if `rc' == 0 {
                local nobs = _N
                local nvars = c(k)
                capture confirm variable ref_area_label
                local haslabel = (_rc == 0)
                capture confirm numeric variable obs_value
                if _rc == 0 {
                    quietly summarize obs_value, meanonly
                    local value_sum = r(sum)
                    quietly count if missing(obs_value)
                    local value_missing = r(N)
                }
            }
            local total = `dl' + `imp'
            di as text "RESULT type=`typ' format=`fmt' run=`run' rc=`rc' download=" %9.3f `dl' " import=" %9.3f `imp' " bytes=" %15.0fc `bytes' " obs=" %12.0fc `nobs'
            file write out "`dataset',`typ',`fmt',`run',`dl',`imp',`total',`bytes',`nobs',`nvars',`value_sum',`value_missing',`haslabel',`rc'" _n
            if `rc' != 0 {
                di as error "Request failed; check the log. Continuing with next scenario."
            }
        }
    }
}
file close out
log close largebench
noi di as result "Results: `results'"
noi di as result "Log: `logpath'"
