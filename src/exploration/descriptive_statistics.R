# Historical exploration; run from repository root. See docs/research-notes.md.
dir.create("results/rerun", recursive=TRUE, showWarnings=FALSE)
library(dplyr)
library(tidyr)
#Loading libraries
library(readr)
library(readxl)
library(dplyr)
library(lmtest)
library(car)
library(sandwich)

df_1<- read_csv("data/processed/country_indicators_2008_2009.csv")
df<- df_1 |> 
    drop_na() |> 
    filter(Country != "Azerbaijan")
descr_2008<- df |> 
    drop_na() |>
    summarize(
        Mean_gov_spend_2008 = mean(gov_spend_percentage.2008, na.rm = TRUE),
        SD_gov_spend_2008 = sd(gov_spend_percentage.2008, na.rm = TRUE),
        Min_gov_spend_2008 = min(gov_spend_percentage.2008, na.rm = TRUE),
        Max_gov_spend_2008 = max(gov_spend_percentage.2008, na.rm = TRUE),
        
        Mean_rate_2008 = mean(rate.2008, na.rm = TRUE),
        SD_rate_2008 = sd(rate.2008, na.rm = TRUE),
        Min_rate_2008 = min(rate.2008, na.rm = TRUE),
        Max_rate_2008 = max(rate.2008, na.rm = TRUE),
        
        Mean_infl_2008 = mean(infl_percentage.2008, na.rm = TRUE),
        SD_infl_2008 = sd(infl_percentage.2008, na.rm = TRUE),
        Min_infl_2008 = min(infl_percentage.2008, na.rm = TRUE),
        Max_infl_2008 = max(infl_percentage.2008, na.rm = TRUE),
        
        Mean_debt_2008 = mean(debt_percentage.2008, na.rm = TRUE),
        SD_debt_2008 = sd(debt_percentage.2008, na.rm = TRUE),
        Min_debt_2008 = min(debt_percentage.2008, na.rm = TRUE),
        Max_debt_2008 = max(debt_percentage.2008, na.rm = TRUE),
        
        Mean_unemploy_2008 = mean(percentage_unemploy.2008, na.rm = TRUE),
        SD_unemploy_2008 = sd(percentage_unemploy.2008, na.rm = TRUE),
        Min_unemploy_2008 = min(percentage_unemploy.2008, na.rm = TRUE),
        Max_unemploy_2008 = max(percentage_unemploy.2008, na.rm = TRUE),
        
        Mean_gdp_growth_2008 = mean(gdp_growth.2008, na.rm = TRUE),
        SD_gdp_growth_2008 = sd(gdp_growth.2008, na.rm = TRUE),
        Min_gdp_growth_2008 = min(gdp_growth.2008, na.rm = TRUE),
        Max_gdp_growth_2008 = max(gdp_growth.2008, na.rm = TRUE),
        
        Mean_M2_2008 = mean(M2.2008, na.rm = TRUE),
        SD_M2_2008 = sd(M2.2008, na.rm = TRUE),
        Min_M2_2008 = min(M2.2008, na.rm = TRUE),
        Max_M2_2008 = max(M2.2008, na.rm = TRUE),
        SD_Developed = sd(Devoloped),
        Observations = n(),
        Mean_Developed = mean(Devoloped)
        # Add more variables as needed
    )
    
descr_2009<- df |> 
    drop_na() |> 
    summarize(
        Mean_gov_spend_2009 = mean(gov_spend_percentage.2009, na.rm = TRUE),
        SD_gov_spend_2009 = sd(gov_spend_percentage.2009, na.rm = TRUE),
        Min_gov_spend_2009 = min(gov_spend_percentage.2009, na.rm = TRUE),
        Max_gov_spend_2009 = max(gov_spend_percentage.2009, na.rm = TRUE),
        
        Mean_rate_2009 = mean(rate.2009, na.rm = TRUE),
        SD_rate_2009 = sd(rate.2009, na.rm = TRUE),
        Min_rate_2009 = min(rate.2009, na.rm = TRUE),
        Max_rate_2009 = max(rate.2009, na.rm = TRUE),
        
        Mean_infl_2009 = mean(infl_percentage.2009, na.rm = TRUE),
        SD_infl_2009 = sd(infl_percentage.2009, na.rm = TRUE),
        Min_infl_2009 = min(infl_percentage.2009, na.rm = TRUE),
        Max_infl_2009 = max(infl_percentage.2009, na.rm = TRUE),
        
        Mean_debt_2009 = mean(debt_percentage.2009, na.rm = TRUE),
        SD_debt_2009 = sd(debt_percentage.2009, na.rm = TRUE),
        Min_debt_2009 = min(debt_percentage.2009, na.rm = TRUE),
        Max_debt_2009 = max(debt_percentage.2009, na.rm = TRUE),
        Observations = n(),
        Mean_unemploy_2009 = mean(percentage_unemploy.2009, na.rm = TRUE),
        SD_unemploy_2009 = sd(percentage_unemploy.2009, na.rm = TRUE),
        Min_unemploy_2009 = min(percentage_unemploy.2009, na.rm = TRUE),
        Max_unemploy_2009 = max(percentage_unemploy.2009, na.rm = TRUE),
        
        Mean_gdp_growth_2009 = mean(gdp_growth.2009, na.rm = TRUE),
        SD_gdp_growth_2009 = sd(gdp_growth.2009, na.rm = TRUE),
        Min_gdp_growth_2009 = min(gdp_growth.2009, na.rm = TRUE),
        Max_gdp_growth_2009 = max(gdp_growth.2009, na.rm = TRUE),
        
        Mean_M2_2009 = mean(M2.2009, na.rm = TRUE),
        SD_M2_2009 = sd(M2.2009, na.rm = TRUE),
        Min_M2_2009 = min(M2.2009, na.rm = TRUE),
        Max_M2_2009 = max(M2.2009, na.rm = TRUE),
        Observations = n()
        # Add more variables as needed
    )

write.csv(descr_2008, "results/rerun/descr_2008.csv", row.names = FALSE)


write.csv(descr_2009, "results/rerun/descr_2009.csv", row.names = FALSE)



#graphs 
# Assuming 'df' is your data frame and 'infl_percentage_2008' is the column name
boxplot(
    df$infl_percentage.2008, # Access the column directly
    main = "Boxplot of Inflation in 2008",
    ylab = "Inflation (%)",
    col = "lightblue",
    border = "darkblue"
)

# Add grid for better readability
grid()
boxplot(
    df$infl_percentage.2009, # Access the column directly
    main = "Boxplot of Inflation in 2009",
    ylab = "Inflation (%)",
    col = "lightblue",
    border = "darkblue"
)

# Add grid for better readability
grid()

