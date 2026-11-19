# Release test matrix

| Area | Case | Expected |
|---|---|---|
| Data | Indicator-frequency retrieval | Valid DTA, obs_value and provenance |
| Data | Ref-area-frequency retrieval | Valid DTA, matching segment |
| Data | type(code), type(label), type(both) | Correct schema, equal observation count |
| Filtering | Multi-value code filters | OR within dimension, API semantics |
| Filtering | Quoted labels and embedded commas | Correct label matching |
| TOC | Both segments, languages en/fr/es | Appropriate localized fields |
| Metadata | Both segments | One catalogue row with last_update |
| General dictionary | sex, source, ref_area | Correct variables and language |
| Dataset dictionary | indicator and ref_area datasets | code/label fields, optional label_short |
| Provenance | Save/reopen DTA | Dataset characteristics persist |
| Errors | Unknown ID, bad options, missing clear | Useful nonzero return code |
| Installation | Clean session and net install | Command and help found |

**Status:** Smoke tests supplied; do not mark entire matrix passed without recorded Stata results. Tests make live API requests; data may change over time.
