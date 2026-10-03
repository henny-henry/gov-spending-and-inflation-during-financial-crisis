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

#Loading files -------
#Just to be sure, to load the files I used just a folder with data, without zip Data folder before

#Inflation
inflation<- read_excel("data/raw/Inflation_deflator/Data_inflation.xlsx")


#Government spending
Govspend<- read_csv("data/raw/Government_spending/total-gov-expenditure-gdp-wdi (1).csv")


#Interest rates
int_rates<-read_xls("data/raw/Interest_rates/API_FR.INR.RINR_DS2_en_excel_v2_228733.xls")


#GDP growth
gdp_growth<-read_xls("data/raw/GDP_Growth/API_NY.GDP.MKTP.KD.ZG_DS2_en_excel_v2_240116.xls")


#Unemployment data
unemploy<-read_xls("data/raw/Unemployment/API_SL.UEM.TOTL.NE.ZS_DS2_en_excel_v2_240720.xls")


#Debt per country
debt<-read_xls("data/raw/Debt/API_GC.DOD.TOTL.GD.ZS_DS2_en_excel_v2_42536.xls")


#M2 Money SUpply
M2<-read_excel("data/raw/M2/API_FM.LBL.BMNY.GD.ZS_DS2_en_excel_v2_12092.xls")


#Tidying GPD_Growth -----
gdp_1<-gdp_growth |> 
    select(-`World Development Indicators`) |> 
    slice(-(1:2))

first_row_values_5 <- unlist(gdp_1[1, ])
names(gdp_1) <- first_row_values_5
gdp_tidy_1<-gdp_1 |> 
    select(-`Indicator Name`) |> 
    select(-`Indicator Code`) |> 
    rename(Country=`Country Name`) |> 
    slice(-(1:1)) |> 
    pivot_longer(
        cols=2:65,
        names_to="year",
        values_to= "gdp_growth"
    ) |>
    mutate(year=as.numeric(year))


#Tidying unemployment data------------
#Same tidying as before
unemploy_1<-unemploy|> 
    select(-`World Development Indicators`) |> 
    slice(-(1:2))

first_row_values_6 <- unlist(unemploy_1[1, ])
names(unemploy_1) <- first_row_values_6

unemploy_tidy_1<-unemploy_1 |> 
    select(-`Indicator Name`) |> 
    select(-`Indicator Code`) |> 
    rename(Country=`Country Name`) |> 
    slice(-(1:1)) |> 
    pivot_longer(
        cols=2:65,
        names_to="year",
        values_to= "percentage"
    ) |>
    mutate(year=as.numeric(year))

#Tidying debt. Percentage of budget that is debt ------
#The same data tidying as in the one before   
debt_1<-debt |> 
    select(-`World Development Indicators`) |> 
    slice(-(1:2))

first_row_values_3 <- unlist(debt_1[1, ])
names(debt_1) <- first_row_values_3


debt_tidy_1<-debt_1 |> 
    select(-`Indicator Name`) |> 
    select(-`Indicator Code`) |> 
    rename(Country=`Country Name`) |> 
    slice(-(1:1)) |> 
    pivot_longer(
        cols=2:65,
        names_to="year",
        values_to= "percentage"
    )|>
    mutate(year=as.numeric(year))
#Tidying inflation data -----
inflation_1 <- inflation|> 
    select(-`IMF Country Code`)|> 
    select(-`Indicator Type`)|> 
    select(-`Series Name`) |> 
    select(-'Country Code')
inflation_tidy_1<- inflation_1 |> 
    pivot_longer(
        cols=2:55,
        names_to="year",
        values_to= "percentage"
    )


#Tidying GovSpend ------
govspend_tidy_1<-Govspend |> 
    select(-'Code') |> 
    mutate(Year=as.numeric(Year)) |> 
    rename(year=Year) |> 
    rename(Country=Entity) |> 
    rename(percentage = `Expense (% of GDP)`)


#Tidying interest rates ------
int_rates_tidy<-int_rates |> 
    select(-`World Development Indicators`) |> 
    slice(-(1:2))

first_row_values_4 <- unlist(int_rates_tidy[1, ])
names(int_rates_tidy) <- first_row_values_4

int_rates_tidy_1<-int_rates_tidy |> 
    select(-`Indicator Name`) |> 
    select(-`Indicator Code`) |> 
    rename(Country=`Country Name`) |> 
    slice(-(1:1)) |> 
    pivot_longer(
        cols=2:65,
        names_to="year",
        values_to= "rate"
    ) |> 
    mutate(year=as.numeric(year))


#Tidying M2--------

M2_tidy<-M2 |> 
    select(-`World Development Indicators`) |> 
    slice(-(1:2))

first_row_values_5 <- unlist(M2_tidy[1, ])
names(M2_tidy) <- first_row_values_5

M2_tidy_1<-M2_tidy |> 
    select(-`Indicator Name`) |> 
    select(-`Indicator Code`) |> 
    rename(Country=`Country Name`) |> 
    slice(-(1:1)) |> 
    pivot_longer(
        cols=2:65,
        names_to="year",
        values_to= "M2"
    ) |> 
    mutate(year=as.numeric(year))



#2008 ------
int_rates_tidy_2008 <- int_rates_tidy_1 |>
    filter(year == 2008) |>
    drop_na(rate) |>
    select(-year)

govspend_tidy_2008 <- govspend_tidy_1 |>
    filter(year == 2008) |>
    drop_na(percentage) |>
    rename(gov_spend_percentage = percentage) |>
    select(-year)

inflation_tidy_2008 <- inflation_tidy_1 |>
    filter(year == 2008) |>
    drop_na(percentage) |>
    rename(infl_percentage = percentage) |>
    select(-year)


debt_tidy_2008 <- debt_tidy_1 |>
    filter(year == 2008) |>
    drop_na(percentage) |>
    rename(debt_percentage = percentage) |>
    select(-year)

unemploy_tidy_2008 <- unemploy_tidy_1 |>
    filter(year == 2008) |>
    drop_na(percentage) |>
    rename(percentage_unemploy = percentage) |>
    select(-year)




M2_tidy_2008 <- M2_tidy_1 |>
    filter(year == 2008) |>
    drop_na(M2) |>
    select(-year)

gdp_tidy_2008 <- gdp_tidy_1 |>
    filter(year == 2008) |>
    drop_na(gdp_growth) |>
    select(-year)

# Merge all datasets by "Country" and drop NAs
total_2008 <- govspend_tidy_2008 |>
    left_join(int_rates_tidy_2008, by = "Country") |>
    left_join(inflation_tidy_2008, by = "Country") |>
    left_join(debt_tidy_2008, by = "Country") |>
    left_join(unemploy_tidy_2008, by = "Country") |>
    left_join(gdp_tidy_2008, by = "Country") |>
    left_join(M2_tidy_2008,by = "Country") |> 
    drop_na() |>
    mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage,M2), as.numeric)) 
# Transform debt_percentage using the natural logarithm
total_2008$log_debt <- log(total_2008$debt_percentage)

# 2008 model -----
# Run the OLS regression
model_2008 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2008)


# Summarize the results
summary(model_2008)






#2008 log scale------

model_2008_log <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + log_debt, data = total_2008)

# Print model summary
print(summary(model_2008_log))

#2009  -----
int_rates_tidy_2009 <- int_rates_tidy_1 |>
    filter(year == 2009) |>
    drop_na(rate) |>
    select(-year)

govspend_tidy_2009 <- govspend_tidy_1 |>
    filter(year == 2009) |>
    drop_na(percentage) |>
    rename(gov_spend_percentage = percentage) |>
    select(-year)
M2_tidy_2009 <- M2_tidy_1 |>
    filter(year == 2009) |>
    drop_na(M2) |>
    select(-year)
inflation_tidy_2009 <- inflation_tidy_1 |>
    filter(year == 2009) |>
    drop_na(percentage) |>
    rename(infl_percentage = percentage) |>
    select(-year)

debt_tidy_2009 <- debt_tidy_1 |>
    filter(year == 2009) |>
    drop_na(percentage) |>
    rename(debt_percentage = percentage) |>
    select(-year)

unemploy_tidy_2009 <- unemploy_tidy_1 |>
    filter(year == 2009) |>
    drop_na(percentage) |>
    rename(percentage_unemploy = percentage) |>
    select(-year)

gdp_tidy_2009 <- gdp_tidy_1 |>
    filter(year == 2009) |>
    drop_na(gdp_growth) |>
    select(-year)

# Merge all datasets by "Country" and drop NAs
total_2009 <- govspend_tidy_2009 |>
    left_join(int_rates_tidy_2009, by = "Country") |>
    left_join(inflation_tidy_2009, by = "Country") |>
    left_join(debt_tidy_2009, by = "Country") |>
    left_join(unemploy_tidy_2009, by = "Country") |>
    left_join(gdp_tidy_2009, by = "Country") |>
    left_join(M2_tidy_2009, by = "Country") |> 
    drop_na() |>
    mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage,M2), as.numeric))

# 2009 model -----
# Run the OLS regression
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2009)
summary(model_2009)

# Transform debt_percentage using the natural logarithm
total_2009$log_debt <- log(total_2009$debt_percentage)

model_2009_log<-lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + log_debt, data = total_2009)
summary(model_2009_log)

Countries_2009 <- total_2009$Country

Countries_2008 <- total_2008$Country

total_2008<- total_2008 |> 
    filter(Country %in% Countries_2009)

total_2009<- total_2009|> 
    filter(Country %in% Countries_2008)



total_2008_2009<- total_2008 |> 
    left_join(total_2009, by = "Country")

total_2008_2009_2010<- total_2008_2009_2010 |> 
    mutate(gov_spend = gov_spend_percentage.x*gov_spend_percentage.y)


model_future<-lm(infl_percentage.y ~ gov_spend+ gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009_2010)
summary(model_future)
vif_values <- vif(model_future)
print(vif_values)
print(mean(vif_values))
bp_test <- bptest(model_future)
print(bp_test)

# 2014 ------
int_rates_tidy_2014 <- int_rates_tidy_1 |>
    filter(year == 2014) |>
    drop_na(rate) |>
    select(-year)

govspend_tidy_2014 <- govspend_tidy_1 |>
    filter(year == 2014) |>
    drop_na(percentage) |>
    rename(gov_spend_percentage = percentage) |>
    select(-year)

inflation_tidy_2014 <- inflation_tidy_1 |>
    filter(year == 2014) |>
    drop_na(percentage) |>
    rename(infl_percentage = percentage) |>
    select(-year)

debt_tidy_2014 <- debt_tidy_1 |>
    filter(year == 2014) |>
    drop_na(percentage) |>
    rename(debt_percentage = percentage) |>
    select(-year)

unemploy_tidy_2014 <- unemploy_tidy_1 |>
    filter(year == 2014) |>
    drop_na(percentage) |>
    rename(percentage_unemploy = percentage) |>
    select(-year)

M2_tidy_2014 <- M2_tidy_1 |>
    filter(year == 2014) |>
    drop_na(M2) |>
    select(-year)

gdp_tidy_2014 <- gdp_tidy_1 |>
    filter(year == 2014) |>
    drop_na(gdp_growth) |>
    select(-year)

# Merge all datasets by "Country" and drop NAs
total_2014 <- govspend_tidy_2014 |>
    left_join(int_rates_tidy_2014, by = "Country") |>
    left_join(inflation_tidy_2014, by = "Country") |>
    left_join(debt_tidy_2014, by = "Country") |>
    left_join(unemploy_tidy_2014, by = "Country") |>
    left_join(gdp_tidy_2014, by = "Country") |>
    left_join(M2_tidy_2014, by = "Country") |> 
    drop_na() |>
    mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage, M2), as.numeric)) |> 
    filter(Country %in% Countries_2008) |> 
    filter(Country %in% Countries_2009)

# Transform debt_percentage using the natural logarithm
total_2014$log_debt <- log(total_2014$debt_percentage)



# 2010 ------
int_rates_tidy_2010 <- int_rates_tidy_1 |>
    filter(year == 2010) |>
    drop_na(rate) |>
    select(-year)

govspend_tidy_2010 <- govspend_tidy_1 |>
    filter(year == 2010) |>
    drop_na(percentage) |>
    rename(gov_spend_percentage = percentage) |>
    select(-year)

inflation_tidy_2010 <- inflation_tidy_1 |>
    filter(year == 2010) |>
    drop_na(percentage) |>
    rename(infl_percentage = percentage) |>
    select(-year)

debt_tidy_2010 <- debt_tidy_1 |>
    filter(year == 2010) |>
    drop_na(percentage) |>
    rename(debt_percentage = percentage) |>
    select(-year)

unemploy_tidy_2010 <- unemploy_tidy_1 |>
    filter(year == 2010) |>
    drop_na(percentage) |>
    rename(percentage_unemploy = percentage) |>
    select(-year)

M2_tidy_2010 <- M2_tidy_1 |>
    filter(year == 2010) |>
    drop_na(M2) |>
    select(-year)

gdp_tidy_2010 <- gdp_tidy_1 |>
    filter(year == 2010) |>
    drop_na(gdp_growth) |>
    select(-year)

# Объединение всех данных по странам и удаление NA
total_2010 <- govspend_tidy_2010 |>
    left_join(int_rates_tidy_2010, by = "Country") |>
    left_join(inflation_tidy_2010, by = "Country") |>
    left_join(debt_tidy_2010, by = "Country") |>
    left_join(unemploy_tidy_2010, by = "Country") |>
    left_join(gdp_tidy_2010, by = "Country") |>
    left_join(M2_tidy_2010, by = "Country") |> 
    drop_na() |>
    mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage, M2), as.numeric))

# Преобразование debt_percentage с использованием натурального логарифма
total_2010$log_debt <- log(total_2010$debt_percentage)










total_2008_2009_2010<- total_2008_2009 |> 
    left_join(total_2010, by = "Country")


write.csv(total_2008_2009_2010, "results/rerun/exploratory_merged.csv", row.names = FALSE)







# 2014 model -----
# Run the OLS regression
model_2014 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage + M2, data = total_2014)

# Summarize the results
summary(model_2014)



