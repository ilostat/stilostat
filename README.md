# ilostat for Stata — v0.9.0 development release candidate

Stata client for the ILOSTAT Plumber API, maintained in the [`ilostat/stilostat`](https://github.com/ilostat/stilostat) repository. Main Stata command: `ilostat`.

**Status:** Development release candidate. Native Stata runtime and SSC installation checks are required before publication. Dataset-specific dictionary retrieval was recently added and needs complete regression sign-off.

## Local development

```stata
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
help ilostat
```

## Example usage

```stata
ilostat get EMP_TEMP_SEX_AGE_NB_A, ref_area(FRA) timefrom(2020) type(both) clear
ilostat info
ilostat get FRA_A, indicator(EMP_TEMP_SEX_AGE_NB) timefrom(2020) clear
ilostat toc, by(indicator) indicator(EMP_TEMP) freq(Q) clear
ilostat toc, by(ref_area) lang(fr) clear
ilostat dic sex, lang(en) clear
ilostat datasetdic EMP_TEMP_SEX_AGE_NB_A, var(sex) clear
ilostat metadata FRA_A, lang(fr) clear
```

## Design

- Server-side filtered requests to `/data/indicator` and `/data/ref_area`.
- DTA by default; CSV optional; `type(code|label|both)`.
- General dictionaries via `/metadata/dic?var=...`.
- Dataset-specific dictionaries via `/metadata/dataset`.
- Catalogue summaries via `/metadata/toc/{indicator|ref_area}`.
- All requests identify the client with `channel=ilostat-stata`.
- No persistent cache and no mandatory external runtime.
- `ilostat info` reports saved provenance. Source `last_update` is available from `ilostat metadata`, not automatically attached.

## Testing

Run `do "H:/_Sys/packages/stilostat/tests/release_smoke.do"` from Stata after installing the release candidate. The test stops on failed assertions, records its results in the Stata output and uses a temporary dataset for provenance persistence.

## Attribution and licensing

Author: David Bescond; affiliation: International Labour Organization (ILO), Department of Statistics / ILOSTAT. Software license: **BSD-2-Clause** (see `LICENSE`), following the Rilostat and pyilostat licensing approach. Proposed copyright notice: © 2026 International Labour Organization. Author: David Bescond. Institutional authorization for the copyright and licensing statement must be confirmed before final publication. The software license does not determine the licensing terms of data retrieved from ILOSTAT. See `ATTRIBUTION.md` and `CITATION.cff`.

## SSC publication

`ssc install ilostat` will work **only after acceptance by SSC**. See `docs/RELEASE.md` for Git and SSC instructions. GitHub releases and SSC distribution are separate publication steps.
