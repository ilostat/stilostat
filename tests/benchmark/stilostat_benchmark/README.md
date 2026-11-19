# ILOSTAT CSV versus DTA benchmark

Run `benchmark_formats.do` in Stata/MP 19's Do-file Editor, from a writable working directory. It uses two supplied ILOSTAT endpoints, requests `type=code` and `type=both`, and downloads each response in CSV and DTA three times. It prints transfer and import times, observations and variable counts into `stilostat_format_benchmark.log`. `copy` time includes remote request processing and transfer; it cannot distinguish them.

## Server-side measurements

Instrument the Plumber handler separately around RDS read, filter, transform, `haven::write_dta` or CSV serialization, and response construction. Record elapsed seconds, output bytes, and peak process memory. Compare matched requests at low concurrency first, then run controlled concurrency benchmarks off-peak. Do not infer server serialization time from client `copy` alone.

## Validation

Compare rows, keys, missingness, text encoding, `obs_value` precision and note columns between the two formats. CSV import may infer column types differently; do not assume equal schemas simply because counts match. Stata may already normalize `ref_area.label` to `ref_area_label` during import. Review the actual imported variable names before adding renaming logic. This script is a timing smoke test, not a complete data-equivalence test.

## Caveats

The exact `type` behavior and whether all URL combinations are supported must be confirmed on the live API. Failed combinations are logged. Server and client caching can influence repeated runs. Run with representative large datasets as well before selecting a default.
