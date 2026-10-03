# Reproduce the paper's two cross-sectional OLS specifications from the saved data.
# Run with Rscript src/analysis.R from the repository root.
if (!file.exists('data/processed/country_indicators_2008_2009.csv')) {
  stop('Run this script from the repository root.')
}
needed <- c('sandwich', 'lmtest', 'car')
missing <- needed[!vapply(needed, requireNamespace, logical(1), quietly=TRUE)]
if (length(missing)) stop('Install dependencies with Rscript install.R')

data <- read.csv('data/processed/country_indicators_2008_2009.csv', check.names=FALSE)
data <- data[complete.cases(data) & data$Country != 'Azerbaijan', ]
stopifnot(nrow(data) == 25L, !anyDuplicated(data$Country))
out <- 'results/rerun'
dir.create(out, recursive=TRUE, showWarnings=FALSE)
capture.output(sessionInfo(), file=file.path(out, 'session-info.txt'))

# Match the historical Stata variable names, including the supplied dummy spelling.
stata_data <- data
names(stata_data) <- tolower(gsub('.', '', names(stata_data), fixed=TRUE))
write.csv(stata_data, file.path(out, 'stata_input.csv'), row.names=FALSE)

results <- list()
for (year in c(2008, 2009)) {
  variables <- paste0(c('gov_spend_percentage', 'rate', 'debt_percentage',
                       'percentage_unemploy', 'gdp_growth', 'M2'), '.', year)
  response <- paste0('infl_percentage.', year)
  for (model in 1:2) {
    predictors <- c(variables, if (model == 2) 'Devoloped')
    fit <- lm(reformulate(predictors, response), data=data)
    label <- paste0('model_', model, '_', year)
    conventional <- summary(fit)$coefficients
    # HC1 corresponds to the finite-sample correction used by Stata regress, robust.
    robust <- lmtest::coeftest(fit, vcov.=sandwich::vcovHC(fit, type='HC1'))
    results[[label]] <- data.frame(
      year=year, model=model, term=rownames(conventional),
      estimate=conventional[, 1], std_error=conventional[, 2], p_value=conventional[, 4],
      hc1_std_error=robust[, 2], hc1_p_value=robust[, 4],
      r_squared=summary(fit)$r.squared, n=nobs(fit), row.names=NULL
    )
    capture.output(summary(fit), robust, car::vif(fit),
                   file=file.path(out, paste0(label, '.txt')))
    png(file.path(out, paste0(label, '_residuals.png')), width=900, height=600)
    plot(fitted(fit), residuals(fit), xlab='Fitted inflation (%)',
         ylab='Residual', main=paste('Model', model, '-', year))
    abline(h=0, lty=2)
    dev.off()
  }
}
write.csv(do.call(rbind, results), file.path(out, 'regression_coefficients.csv'), row.names=FALSE)
message('Completed four OLS fits with conventional and HC1 standard errors. Outputs: ', out)
