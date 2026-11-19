# v0.9.1-rc fixes

- Changed country-frequency identifier matching from `{3}` repetition to explicit `[A-Z][A-Z][A-Z]` in all three segment-detection branches (get, metadata, datasetdic), avoiding incompatibility with Stata legacy `regexm()`.
- Rebuilt `ilostat.sthlp` with SMCL `{p_end}` paragraph terminators and separated syntax/examples.
- Added explicit and automatic reference-area metadata regression checks.
- No changes to the API transport or filtering algorithms.

Run `discard`, `which ilostat`, `help ilostat`, then `do tests/release_smoke.do` from Stata. The help display and runtime behavior still require validation in Stata.
