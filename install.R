# R >= 4.1 (native pipe syntax is used in the exploratory scripts).
# No original package lockfile was supplied; sessionInfo() is saved on each rerun.
packages <- c('sandwich', 'lmtest', 'car', 'readxl', 'readr', 'dplyr', 'tidyr')
missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly=TRUE)]
if (length(missing)) install.packages(missing, repos='https://cloud.r-project.org')
