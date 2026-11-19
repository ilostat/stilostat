* Run from Stata Do-file Editor; no changes to production API.
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
ilostat dic sex, lang(en) clear
confirm variable sex
count
list in 1/5
ilostat dic source, lang(fr) clear
confirm variable source
confirm variable source_label
count
list in 1/5
ilostat dic ref_area, lang(es) clear
confirm variable ref_area
count
list in 1/5
