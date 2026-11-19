# stilostat large-format benchmark

Benchmark `EMP_TEMP_SEX_AGE_ECO_NB_Q` against the existing `/data/indicator` endpoint. The benchmark downloads each response to a temporary file, times download (server processing + network), times Stata import, and records file size where supported, observation count, variable count, `obs_value` sum and missing count, and the presence of `ref_area_label`.

## Run

1. Copy `benchmark_large.do` to `H:/_Sys/packages/stilostat/tests/benchmark/`.
2. Open it in the Stata Do-file Editor and execute the entire file.
3. Share `large_format_results.csv` and `large_format_benchmark.log` from the same directory.

Default is **2 repetitions** per combination (8 large requests total), to limit production API load. Set `local repeats 3` for 12 requests if the first run is stable. No extra large-dataset warm-up is performed. Execute off peak if possible. The `type(both)` responses may be considerably larger than `type(code)`.

The `bytes` field may be missing if the installed Stata version does not expose file position after `file seek ... eof`. In that case use PowerShell `Get-Item` on a saved download; the timings remain useful.

## Interpretation

- `download_seconds` includes API processing, serialization, network and file writing. It does **not** isolate API CPU or RAM.
- `import_seconds` measures Stata parsing/loading.
- `obs_value_sum` is a **coarse** consistency check, not an exact row-by-row comparison. Numeric storage precision and missing-value semantics should be checked separately before changing the package default.
- `type(both)` may return different column names for CSV and DTA. `ref_area_label_present=0` does not establish that CSV lacks labels; inspect `describe` after a CSV import.
- This script makes no changes to `ilostat.ado` or the production API.
