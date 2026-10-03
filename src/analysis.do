* Run src/analysis.R first, then run this file from the repository root.
clear all
set more off
import delimited "results/rerun/stata_input.csv", clear varnames(1)


*Data statistics 
summarize gov_spend_percentage2008	rate2008	infl_percentage2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008		gov_spend_percentage2009	rate2009	infl_percentage2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009	devoloped


*First model for 2008 and 2009
*Assumptions: Multicollinearity:


*For 2008
reg infl_percentage2008 gov_spend_percentage2008	rate2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008 
vif 

*For 2009
reg infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 
vif 
* Heteroskedasticity checks:


*For 2008:
reg infl_percentage2008 gov_spend_percentage2008	rate2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008
estat hettest


*Robust regression for 2008:

reg infl_percentage2008 gov_spend_percentage2008	rate2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008,  robust



*For 2009:

reg infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009

estat hettest	
				
*Robust for 2009:
						
reg infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009,  robust
 		
						
* Linearity for 2008:
regress infl_percentage2008 gov_spend_percentage2008 rate2008 debt_percentage2008 percentage_unemploy2008 gdp_growth2008 m22008

* Generate residuals:
predict resid_2008, residuals

* Generate fitted values:
predict fitted_2008, xb

* Create residuals vs. fitted values plot:
rvfplot, yline(0) title("Residuals vs Fitted Values for 2008")


* Linearity for 2009:
regress infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009

* Generate residuals:
predict resid_2009, residuals

* Generate fitted values:
predict fitted_2009, xb

* Create residuals vs. fitted values plot:
rvfplot, yline(0) title("Residuals vs Fitted Values for 2009")

* Historical duplicate: the following command fits 2009, despite the original 2008 label.

regress infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009

*Final Regression for model 1 for 2009:
regress infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009




*Second model for 2008 and 2009




*Assumptions: Multicollinearity:
*For 2008
reg infl_percentage2008 gov_spend_percentage2008	rate2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008 devoloped
vif 

*For 2009
reg infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 devoloped
vif 
* Heteroskedasticity checks:


*For 2008:
reg infl_percentage2008 gov_spend_percentage2008	rate2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008 devoloped
estat hettest


*Robust regression for 2008:

reg infl_percentage2008 gov_spend_percentage2008	rate2008	debt_percentage2008	percentage_unemploy2008	gdp_growth2008	m22008 devoloped,  robust



*For 2009:

reg infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 devoloped

estat hettest	
				
*Robust for 2009:
						
reg infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 devoloped,  robust
 		
						
* Linearity for 2008:
regress infl_percentage2008 gov_spend_percentage2008 rate2008 debt_percentage2008 percentage_unemploy2008 gdp_growth2008 m22008 devoloped

* Generate residuals:
predict resid_2008_2, residuals

* Generate fitted values:
predict fitted_2008_2, xb

* Create residuals vs. fitted values plot:
rvfplot, yline(0) title("Residuals vs Fitted Values for 2008")


* Linearity for 2009:
regress infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 devoloped

* Generate residuals:
predict resid_2009_2, residuals

* Generate fitted values:
predict fitted_2009_2, xb

* Create residuals vs. fitted values plot:
rvfplot, yline(0) title("Residuals vs Fitted Values for 2009")

* Historical duplicate: the following command fits 2009, despite the original 2008 label.

regress infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 devoloped

*Final Regression for model 1 for 2009:
regress infl_percentage2009 gov_spend_percentage2009	rate2009	debt_percentage2009	percentage_unemploy2009	gdp_growth2009	m22009 devoloped

