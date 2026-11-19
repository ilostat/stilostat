* Run in Stata Do-file Editor on Windows.
* The server must confirm the User-Agent from access logs.
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) transport(powershell) clear
assert _N > 0
count
* Existing fallback, for comparison (does not guarantee User-Agent):
* ilostat get SDG_0552_NOC_RT_A, timefrom(2015) transport(copy) clear
