# Provenance, discrepancies, and validation

The report remains the primary research artifact; its student number and PDF metadata were removed. Original tables, figures, data values, and model specifications are retained. The new R entry point fits the report's equations against the supplied final table; it does not claim to reconstruct undocumented data preparation.

## Inconsistencies preserved

- **Verified data/report mismatch:** a fresh R 4.3.2 run on the supplied CSV gives spending coefficients 0.177650 / 0.048341 for Model 1 (2008/2009), and 0.199390 / 0.050061 for Model 2. Corresponding R² values are 0.800410 / 0.650617 / 0.815148 / 0.666208. These differ materially from Tables 8–9. Model 1's coefficients were independently cross-checked with NumPy least squares. The source of the historical discrepancy is not established; report numbers remain labeled as reported, and rerun numbers are in `results/verification_spending_coefficients.csv`. The rerun's 2008 Model 2 conventional p-value is 0.0357 (HC1: 0.0776), so the report's overall significance conclusion cannot simply be attributed to this saved dataset.

- The report variously mentions 26, 25, and 23 countries. The saved processed CSV has 25 rows, and Tables 1–2 and 7–9 report 25 observations per year. Its old filename mentioned 2010, but it contains 2008/2009 measurements only.
- The original R preparation script references `total_2008_2009_2010` before creation, contains additional 2010/2014 exploration, and never constructs the final `Devoloped` column or the final year-specific names. It cannot regenerate the final CSV unaided. The earlier premature `summary(model_2008_log)` call was removed, but substantive ambiguities remain documented rather than guessed.
- The supplied developed-economy coding includes Belarus as 1. Its construction/source mapping is not recorded in executable code. Values were preserved; do not assume a current classification.
- The spending series is labeled `Expense (% of GDP)` in the source CSV. The report's broader wording should not be taken as a verified measure of every category of government spending.
- The interest series file is `FR.INR.RINR` (real interest rate), despite the report calling it average central-bank rates. `FM.LBL.BMNY.GD.ZS` measures broad money relative to GDP, not money-supply growth.
- The inflation workbook says `GDP deflator Index growth rate`; a report reference instead labels inflation as consumer prices. No indicator was substituted during cleanup.
- The report's Model 2 spending coefficient for 2008 has a 10% significance star in both the OLS and robust tables, while the narrative says spending is not significant. These annotations should be checked against computed p-values; they are not silently propagated into the README.
- The low-VIF discussion ends with a contradictory sentence claiming multicollinearity. Diagnostics also do not establish absence of omitted-variable bias or global representativeness, despite stronger wording in the report.
- The original Stata sections labeled final regressions for 2008 actually repeat 2009 commands. Comments now identify those duplicates; the earlier correctly specified 2008 commands remain. Invalid `#` comment markers were fixed and an explicit data import was added.

## Preservation and cleanup

The prior scripts are under `src/exploration/`. The R workspace contains meaningful extra-year models and intermediate datasets and is retained as `docs/archive/research_workspace.RData`; use `load(..., envir=new.env())` deliberately rather than auto-loading it. The exploration history is retained for provenance, not as a runnable script. Removed IDE state included an unrelated unsaved course-selection buffer, preserved only in the private workspace backup outside this repository.

The dependency installer specifies direct packages rather than inventing historical package versions. Newly generated files are isolated in `results/rerun/`. No dataset values or report conclusions were changed.

## Validation

Executed all four main R regressions successfully with R 4.3.2, generated tables/plots/session information, and independently verified Model 1 coefficients using NumPy least squares. The optional Stata script was inspected but not executed (no Stata executable available). Historical raw-data reconstruction is incomplete for the reasons above; no claim of exact report reproduction is made.
