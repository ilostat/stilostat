# v0.9.0 release and SSC checklist

- [ ] Run `tests/test_datasetdic.do` and `tests/test_regression.do` in Stata/MP 19.
- [ ] Confirm all dictionary response fields and empty-match behavior.
- [ ] Confirm Windows, macOS and Linux compatibility with native `copy`.
- [ ] Test labels with commas, partial code filters, both data segments and all languages.
- [ ] Verify source metadata, provenance, no persistent cache and channel identification.
- [ ] Review/complete `ilostat.sthlp`, `ilostat_toc.sthlp`, `ilostat_metadata.sthlp`, `ilostat_datasetdic.sthlp`.
- [ ] Confirm author, maintainer, ILO funding/copyright and approved license.
- [ ] Check Stata package-name availability in SSC.
- [ ] Prepare `ilostat.pkg`, `stata.toc`, LICENSE and release files, with complete installation manifest.
- [ ] Test `net install` from release URL on a clean Stata profile.
- [ ] Create a tagged GitHub release; submit to SSC only after review and approval.
