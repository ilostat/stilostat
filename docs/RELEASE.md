# Git and SSC release checklist

## 1. Preserve existing repository

In Positron PowerShell, run:

```powershell
cd H:\_Sys\packages\stilostat
git status --short
git remote -v
git branch --show-current
```

Do not run `git init` if `.git` already exists. If `origin` is missing, create the GitHub repository under `ilostat` first and then add the remote. Do not overwrite existing commits.

## 2. Integrate release candidate

Back up `ilostat.ado`, inspect the patch against your current source and copy the prepared files into the existing repository. The package manifest references only `ilostat.ado` and `ilostat.sthlp`; both must be in the repository root. Keep tests and docs under their directories.

## 3. Local Stata verification

```stata
adopath ++ "H:/_Sys/packages/stilostat"
discard
which ilostat
help ilostat
do "H:/_Sys/packages/stilostat/tests/release_smoke.do"
```

## 4. Git review, commit and push (only after tests pass)

```powershell
cd H:\_Sys\packages\stilostat
git diff --check
git status --short
git add ilostat.ado ilostat.sthlp ilostat.pkg stata.toc README.md ATTRIBUTION.md CITATION.cff .gitignore docs tests examples
git diff --cached --check
git diff --cached --stat
git commit -m "release: prepare ilostat Stata v0.9.0 candidate"
git push -u origin HEAD
```

Review staged files for credentials and accidental data outputs before committing. If the remote repository has diverged, fetch and reconcile rather than force-pushing.

## 5. SSC readiness

- Obtain institutional approval for copyright, funder statement, and a concrete license file.
- Confirm SSC package name availability and submission requirements with SSC maintainers.
- Verify Stata version compatibility (ado declares version 16.0) and test on Windows plus another supported platform.
- Verify all help links and every example; test on a clean Stata session.
- Test installation from an accessible distribution URL using `net install ilostat, from("...")` once the package files are hosted in an SSC-compatible layout.
- Create a Git tag only after acceptance tests; submit the reviewed package to SSC maintainers. A GitHub push does not publish to SSC.
