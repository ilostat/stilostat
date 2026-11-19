version 16.0
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

* Full catalogue; known schema checks.
ilostat toc, clear
assert _N > 1000
confirm variable id
confirm variable indicator
confirm variable indicator_label
confirm variable freq
confirm variable freq_label
confirm variable classification
confirm variable classif_labels
count if strpos(upper(indicator), "EMP_TEMP") > 0
assert r(N) > 0

* Filtered catalogue: verify every retained observation.
ilostat toc, indicator(EMP_TEMP) freq(Q) clear
assert _N > 0
assert strpos(upper(indicator), "EMP_TEMP") > 0
assert upper(freq) == "Q"
list id indicator_label freq in 1/5

* Regression check: previous data command remains available.
ilostat get SDG_0552_NOC_RT_A, timefrom(2015) clear
assert _N > 0
