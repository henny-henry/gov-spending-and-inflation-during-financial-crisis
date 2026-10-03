filter(year == 2007) |>
drop_na(percentage) |>
rename(percentage_unemploy = percentage) |>
select(-year)
gdp_tidy_2007 <- gdp_tidy_1 |>
filter(year == 2007) |>
drop_na(gdp_growth) |>
select(-year)
# Merge all datasets by "Country" and drop NAs
total_2007 <- govspend_tidy_2007 |>
left_join(int_rates_tidy_2007, by = "Country") |>
left_join(inflation_tidy_2007, by = "Country") |>
left_join(debt_tidy_2007, by = "Country") |>
left_join(unemploy_tidy_2007, by = "Country") |>
left_join(gdp_tidy_2007, by = "Country") |>
drop_na() |>
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage), as.numeric))
# 2007 model -----
# Run the OLS regression
model_2007 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2007)
summary(model_2007)
#2009 model -----
int_rates_tidy_2009 <- int_rates_tidy_1 |>
filter(year == 2009) |>
drop_na(rate) |>
select(-year)
govspend_tidy_2009 <- govspend_tidy_1 |>
filter(year == 2009) |>
drop_na(percentage) |>
rename(gov_spend_percentage = percentage) |>
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
drop_na() |>
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage), as.numeric))
# 2009 model -----
# Run the OLS regression
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2009)
summary(model_2009)
# Transform debt_percentage using the natural logarithm
total_2009$log_debt <- log(total_2008$debt_percentage)
# Transform debt_percentage using the natural logarithm
total_2009$log_debt <- log(total_2009$debt_percentage)
model_2009_log<-lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + log_debt, data = total_2009)
summary(model_2009_log)
View(total_2009)
Countries_2009 <- total_2009$Country
Countries_2008 <- total_2008$Country
total_2008<- total_2008 |>
filter(Country = Countries_2009)
Countries_2009 <- total_2009$Country
Countries_2008 <- total_2008$Country
total_2008<- total_2008 |>
filter(Country == Countries_2009)
Countries_2009 <- total_2009$Country
Countries_2008 <- total_2008$Country
total_2008<- total_2008 |>
filter(Country %in% Countries_2009)
total_2009<- total_2009|>
filter(Country %in% Countries_2008)
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2009)
summary(model_2009)
model_2008 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2008)
# Summarize the results
summary(model_2008)
total_2008_2009<- total_2008 |>
left_join(total_2009, join_by(Country)
total_2008_2009<- total_2008 |>
total_2008_2009<- total_2008 |>
left_join(total_2009, by = "Country")
View(total_2008_2009)
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + log_debt.y, data = total_2008_2009)
summary(model_future)
M2<-read_excel("Data/M2/API_FM.LBL.BMNY.GD.ZS_DS2_en_excel_v2_12092.xls")
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
total_2008 <- govspend_tidy_2008 |>
left_join(int_rates_tidy_2008, by = "Country") |>
left_join(inflation_tidy_2008, by = "Country") |>
left_join(debt_tidy_2008, by = "Country") |>
left_join(unemploy_tidy_2008, by = "Country") |>
left_join(gdp_tidy_2008, by = "Country") |>
left_join(M2_tidy_2008,by = "Country")
M2_tidy_2008 <- M2_tidy_1 |>
filter(year == 2008) |>
drop_na(percentage) |>
select(-year)
M2_tidy_2008 <- M2_tidy_1 |>
filter(year == 2008) |>
drop_na(M2) |>
select(-year)
# Merge all datasets by "Country" and drop NAs
total_2008 <- govspend_tidy_2008 |>
left_join(int_rates_tidy_2008, by = "Country") |>
left_join(inflation_tidy_2008, by = "Country") |>
left_join(debt_tidy_2008, by = "Country") |>
left_join(unemploy_tidy_2008, by = "Country") |>
left_join(gdp_tidy_2008, by = "Country") |>
left_join(M2_tidy_2008,by = "Country")
total_2008 <- govspend_tidy_2008 |>
left_join(int_rates_tidy_2008, by = "Country") |>
left_join(inflation_tidy_2008, by = "Country") |>
left_join(debt_tidy_2008, by = "Country") |>
left_join(unemploy_tidy_2008, by = "Country") |>
left_join(gdp_tidy_2008, by = "Country") |>
left_join(M2_tidy_2008,by = "Country") |>
drop_na()
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
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2009)
summary(model_2009)
model_2008 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2008)
# Summarize the results
summary(model_2008)
model_2008 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2008)
# Summarize the results
summary(model_2008)
M2_tidy_2009 <- M2_tidy_1 |>
filter(year == 2009) |>
drop_na(M2) |>
select(-year)
total_2009 <- govspend_tidy_2009 |>
left_join(int_rates_tidy_2009, by = "Country") |>
left_join(inflation_tidy_2009, by = "Country") |>
left_join(debt_tidy_2009, by = "Country") |>
left_join(unemploy_tidy_2009, by = "Country") |>
left_join(gdp_tidy_2009, by = "Country") |>
left_join(M2_tidy_2009, by = "Country") |>
drop_na() |>
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage), as.numeric))
View(total_2009)
Countries_2009 <- total_2009$Country
Countries_2008 <- total_2008$Country
total_2008<- total_2008 |>
filter(Country %in% Countries_2009)
total_2009<- total_2009|>
filter(Country %in% Countries_2008)
total_2008_2009<- total_2008 |>
left_join(total_2009, by = "Country")
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + log_debt.y, data = total_2008_2009)
total_2008_2009<- total_2008 |>
left_join(total_2009, by = "Country")
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + log_debt.y, data = total_2008_2009)
total_2009$log_debt <- log(total_2009$debt_percentage)
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage, data = total_2009)
summary(model_2009)
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2009)
summary(model_2009)
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2009)
summary(model_2009)
total_2009 <- govspend_tidy_2009 |>
left_join(int_rates_tidy_2009, by = "Country") |>
left_join(inflation_tidy_2009, by = "Country") |>
left_join(debt_tidy_2009, by = "Country") |>
left_join(unemploy_tidy_2009, by = "Country") |>
left_join(gdp_tidy_2009, by = "Country") |>
left_join(M2_tidy_2009, by = "Country") |>
drop_na() |>
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage,M2), as.numeric))
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2009)
summary(model_2009)
# 2021 ------
int_rates_tidy_2021 <- int_rates_tidy_1 |>
filter(year == 2021) |>
drop_na(rate) |>
select(-year)
govspend_tidy_2021 <- govspend_tidy_1 |>
filter(year == 2021) |>
drop_na(percentage) |>
rename(gov_spend_percentage = percentage) |>
select(-year)
inflation_tidy_2021 <- inflation_tidy_1 |>
filter(year == 2021) |>
drop_na(percentage) |>
rename(infl_percentage = percentage) |>
select(-year)
debt_tidy_2021 <- debt_tidy_1 |>
filter(year == 2021) |>
drop_na(percentage) |>
rename(debt_percentage = percentage) |>
select(-year)
unemploy_tidy_2021 <- unemploy_tidy_1 |>
filter(year == 2021) |>
drop_na(percentage) |>
rename(percentage_unemploy = percentage) |>
select(-year)
M2_tidy_2021 <- M2_tidy_1 |>
filter(year == 2021) |>
drop_na(M2) |>
select(-year)
gdp_tidy_2021 <- gdp_tidy_1 |>
filter(year == 2021) |>
drop_na(gdp_growth) |>
select(-year)
# Merge all datasets by "Country" and drop NAs
total_2021 <- govspend_tidy_2021 |>
left_join(int_rates_tidy_2021, by = "Country") |>
left_join(inflation_tidy_2021, by = "Country") |>
left_join(debt_tidy_2021, by = "Country") |>
left_join(unemploy_tidy_2021, by = "Country") |>
left_join(gdp_tidy_2021, by = "Country") |>
left_join(M2_tidy_2021, by = "Country") |>
drop_na() |>
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage, M2), as.numeric))
# Transform debt_percentage using the natural logarithm
total_2021$log_debt <- log(total_2021$debt_percentage)
# 2021 model -----
# Run the OLS regression
model_2021 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage + M2, data = total_2021)
# Summarize the results
summary(model_2021)
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
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage, M2), as.numeric))
# Transform debt_percentage using the natural logarithm
total_2014$log_debt <- log(total_2014$debt_percentage)
# 2014 model -----
# Run the OLS regression
model_2014 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage + M2, data = total_2014)
# Summarize the results
summary(model_2014)
total_2014 <- govspend_tidy_2014 |>
left_join(int_rates_tidy_2014, by = "Country") |>
left_join(inflation_tidy_2014, by = "Country") |>
left_join(debt_tidy_2014, by = "Country") |>
left_join(unemploy_tidy_2014, by = "Country") |>
left_join(gdp_tidy_2014, by = "Country") |>
left_join(M2_tidy_2014, by = "Country") |>
drop_na() |>
mutate(across(c(gov_spend_percentage, gdp_growth, rate, percentage_unemploy, debt_percentage, M2), as.numeric)) |>
filter(Country %in% Countries_2008)
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
# Run the OLS regression
model_2014 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage + M2, data = total_2014)
# Summarize the results
summary(model_2014)
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
total_2009$log_debt <- log(total_2009$debt_percentage)
Countries_2009 <- total_2009$Country
Countries_2008 <- total_2008$Country
total_2008<- total_2008 |>
filter(Country %in% Countries_2009)
total_2009<- total_2009|>
filter(Country %in% Countries_2008)
total_2008_2009<- total_2008 |>
left_join(total_2009, by = "Country")
View(total_2008_2009)
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
View(total_2008_2009_2010)
model_2009 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2009)
summary(model_2009)
# Run the OLS regression
model_2008 <- lm(infl_percentage ~ gov_spend_percentage + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2008)
# Summarize the results
summary(model_2008)
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + percentage_debt.y, data = total_2008_2009)
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y, data = total_2008_2009)
summary(model_future)
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009)
summary(model_future)
View(total_2008_2009_2010)
model_future<-lm(infl_percentage ~ gov_spend_percentage.x + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2008_2009)
model_future<-lm(infl_percentage ~ gov_spend_percentage.x + gdp_growth + rate + percentage_unemploy + debt_percentage+M2, data = total_2008_2009_2010)
summary(model_future)
.
model_future<-lm(infl_percentage ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009)
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x + gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009)
summary(model_future)
vif_values <- vif(model_future)
print(vif_values)
bp_test <- bptest(model_future)
print(bp_test)
print(mean(vif_values))
model_future<-lm(infl_percentage.y ~ gov_spend_percentage.x*gov_spend_percentage.y+ gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009)
summary(model_future)
total_2008_2009_2010<- total_2008_2009_2010 |>
mutate(gov_spend = gov_spend_percentage.x*gov_spend_percentage.y)
model_future<-lm(infl_percentage.y ~ gov_spend+ gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009)
model_future<-lm(infl_percentage.y ~ gov_spend+ gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009_2010
summary(model_future)
model_future<-lm(infl_percentage.y ~ gov_spend+ gdp_growth.y + rate.y + percentage_unemploy.y + debt_percentage.y+M2.y, data = total_2008_2009_2010)
summary(model_future)
