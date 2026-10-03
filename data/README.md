# Data provenance

`processed/country_indicators_2008_2009.csv` is the supplied analysis table, renamed from `total_2008_2009_2010.csv` without changing its contents. It contains 25 countries, 2008/2009 indicators, a 2008 log-debt column, and the original `Devoloped` dummy (spelling retained). Azerbaijan is already absent.

The compact files in `raw/` are original download snapshots. Their filenames retain the indicator identifiers and source export versions:

| Folder / indicator | Meaning recorded in the project |
| --- | --- |
| `Government_spending/` | Our World in Data / World Bank expense as % GDP |
| `Inflation_deflator/` | GDP-deflator growth workbook and `NY.GDP.DEFL.KD.ZG` export |
| `GDP_Growth/`, `NY.GDP.MKTP.KD.ZG` | Annual GDP growth |
| `Interest_rates/`, `FR.INR.RINR` | Real interest rate |
| `Unemployment/`, `SL.UEM.TOTL.NE.ZS` | Unemployment, national estimate |
| `Debt/`, `GC.DOD.TOTL.GD.ZS` | Central-government debt as % GDP |
| `M2/`, `FM.LBL.BMNY.GD.ZS` | Broad money as % GDP |

The military-expenditure exports (`MS.MIL.XPND.*`) were supplied but are unused by the final specifications. They are retained as exploratory source context. To obtain updated source data, search the World Bank indicators by these exact codes and Our World in Data for the recorded expense series. Updated releases may differ from these snapshots; they will not necessarily reproduce the submitted tables. The report contains the original references. The GDP-deflator workbook's exact download provenance and the dummy coding cannot be fully recovered from the saved scripts.

Country names and aggregate economic values are public statistical data. No individual-level observations are present. Source datasets retain their providers' terms; no new license is asserted over them.
