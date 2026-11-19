# Architecture — first API prototype

Native Stata -> ILOSTAT classification endpoint -> on-demand .dta or CSV -> Stata dataset.

No pre-generated `.dta` fleet and no Python/R dependency on client machines.

Future work: validate the complete API filter contract, label and partial matching, measure .dta vs CSV latency and transfer size, add local cache keyed by dataset version, implement TOC/dictionaries, then SSC packaging. SDMX is deliberately deferred.
