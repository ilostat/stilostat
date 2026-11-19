* Run in Stata Do-file Editor
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) clear
local request : char _dta[ilostat_url]
display `"`request'"'
assert strpos(`"`request'"', "channel=ilostat-stata") > 0
count
