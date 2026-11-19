# v0.9.2-rc — Year validation fix

Stata legacy `regexm()` does not reliably support `{4}` repetition in this context. `timefrom()` and `timeto()` now validate a four-character length and four explicit digits.

Preserved: v0.9.1 metadata routing correction, SMCL help, API commands and native DTA retrieval.

Run `discard`, `which ilostat`, then `do tests/release_smoke.do`. This test intentionally expects r(198) for `timefrom(20A0)` and verifies that `timefrom(2020)` succeeds. No Stata runtime was available during preparation.
