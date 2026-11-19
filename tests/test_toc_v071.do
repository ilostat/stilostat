* stilostat v0.7.1 TOC smoke tests. Run from Stata Do-file Editor.
version 16.0
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat

* Previously validated indicator route
ilostat toc, clear
assert _N > 1000
confirm variable indicator_label

* Search with quoted label, previously returned zero
count if strpos(ustrlower(indicator_label), "unemployment") > 0
local expected = r(N)
ilostat toc, label("unemployment") clear
assert _N == `expected'
assert _N > 0

* Spanish indicator catalogue
ilostat toc, by(indicator) lang(es) clear
confirm variable indicator_label
count

* Reference-area route: first validation; inspect actual schema
ilostat toc, by(ref_area) lang(fr) clear
describe
count
capture confirm variable ref_area_label
if !_rc list ref_area ref_area_label in 1/5
