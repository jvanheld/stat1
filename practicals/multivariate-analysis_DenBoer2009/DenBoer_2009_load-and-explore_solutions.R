## ----include=FALSE, echo=FALSE, eval=TRUE-----------------------------
library(knitr)
options(width = 300)
knitr::opts_chunk$set(
  fig.width = 7, fig.height = 5, 
  fig.path = 'figures/02_combinatorix_',
  fig.align = "center", 
  size = "tiny", 
  echo = TRUE, eval = TRUE, 
  warning = FALSE, message = FALSE, 
  results = TRUE, comment = "")
# knitr::asis_output("\\footnotesize")



## ---------------------------------------------------------------------
#' @title Download a set of files from a Web site
#' @author Jacques van Helden
#' @description Download a set of files from a Web site and store them in a destination directory if they do not exist yet there. 
#' @param files a vector with the file names
#' @param dataURL the URL of the folder containing the files to download
#' @param destDir local destination directory. Will be created if it does not exist. 
#' @return no return value
#' @export
DownloadMyFiles <- function(files, 
                            dataURL,
                            destDir) {
  
  ## Create local directory
  dir.create(destDir, recursive = TRUE, showWarnings = FALSE)
  
  for (f in files) {
    
    ## Destination file
    destFile <- file.path(destDir, f)
    
    ## Check if file exists
    if (file.exists(destFile)) {
      message("skipping download because file exists: ", destFile)
    } else {
      sourceURL <- file.path(dataURL, f)
      download.file(url = sourceURL, destfile = destFile)
    }
  }
}



## ---------------------------------------------------------------------
## URL fo the folder containing the data fle
dataURL <- "https://github.com/jvanheld/stat1/raw/master/data/DenBoer_2009/"

files <- c(
  expr = "GSE13425_Norm_Whole.tsv.gz",
  pheno = "phenoData_GSE13425.tsv.gz",
  groups = "GSE13425_group_descriptions.tsv.gz"
)

## Local data dir
destDir <- "~/STAT2_CMB_practicals/den-boer-2009/data/"

## Call the function to download the files
DownloadMyFiles(files = files, dataURL = dataURL, destDir = destDir)

kable(data.frame(list.files(destDir)), caption = "Content of the destination directory after file download. ")



## ---------------------------------------------------------------------

#### Load data tables ####

## Load expression table
exprTable <- read.table(file.path(destDir, files["expr"]), 
                        sep = "\t", 
                        header = TRUE, 
                        quote = "",
                        row.names = 1)
# dim(exprTable)
# names(exprTable)
# head(exprTable)

## Load metadescriptions (pheno table)
phenoTable <- read.table(file.path(destDir, files["pheno"]), 
                         sep = "\t", 
                         header = TRUE, 
                         quote = "",
                         row.names = 1)
# dim(phenoTable)
# View(phenoTable)
# names(phenoTable)
sampleGroup <- as.vector(phenoTable$Sample.title)

## Load group descriptions
groupDescriptions <- read.table(file.path(destDir, files["groups"]), 
                                sep = "\t", 
                                header = TRUE, 
                                quote = "",
                                row.names = 1)
# dim(phenoTable)




## ----row°stats--------------------------------------------------------
#### Compute statistics on each column ####
colStat <- data.frame(
  mean = apply(exprTable, 2, mean, na.rm = TRUE),
  var = apply(exprTable, 2, var, na.rm = TRUE),
  sd = apply(exprTable, 2, sd, na.rm = TRUE),
  min = apply(exprTable, 2, min, na.rm = TRUE),
  perc05 = apply(exprTable, 2, quantile, probs = 0.05, na.rm = TRUE),
  perc25 = apply(exprTable, 2, quantile, probs = 0.25, na.rm = TRUE),
  perc50 = apply(exprTable, 2, quantile, probs = 0.50, na.rm = TRUE),
  perc75 = apply(exprTable, 2, quantile, probs = 0.75, na.rm = TRUE),
  perc95 = apply(exprTable, 2, quantile, probs = 0.95, na.rm = TRUE),
  max = apply(exprTable, 2, max, na.rm = TRUE),
  IQR = apply(exprTable, 2, IQR, na.rm = TRUE)
)


## ----col_stats--------------------------------------------------------
#### Compute statistics on each row ####
rowStat <- data.frame(
  mean = apply(exprTable, 1, mean),
  var = apply(exprTable, 1, var),
  sd = apply(exprTable, 1, sd),
  min = apply(exprTable, 1, min),
  perc05 = apply(exprTable, 1, quantile, probs = 0.05),
  perc25 = apply(exprTable, 1, quantile, probs = 0.25),
  perc50 = apply(exprTable, 1, quantile, probs = 0.50),
  perc75 = apply(exprTable, 1, quantile, probs = 0.75),
  perc95 = apply(exprTable, 1, quantile, probs = 0.95),
  max = apply(exprTable, 1, max),
  IQR = apply(exprTable, 1, IQR)
)


## ----expr_distrib_all, fig.width=7, fig.height=5, fig.cap="Empirical distribution of all the expression values. "----
#### Distribution of values across all samples ####
hist(unlist(exprTable), breaks = 100)


## ---------------------------------------------------------------------
library(knitr)
purl(Rmd = "Den_Boer_use_case.Rmd",  = "Den_Boer_use_case.R")


## ---------------------------------------------------------------------
sessionInfo()

