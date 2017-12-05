## ----include=FALSE, echo=FALSE, eval=TRUE--------------------------------
library(knitr)

options(width=300)
knitr::opts_chunk$set(
  fig.width = 7, fig.height = 5, 
  fig.align = "center", 
  fig.path = "figures/sampling-estimation_",
  size = "tiny", 
  echo = FALSE, eval=TRUE, 
  warning = FALSE, message = FALSE, 
  results = TRUE, comment = "")
# knitr::asis_output("\\footnotesize")

dir.main <- "~/stat1"
dir.slides <- file.path(dir.main, "slides")
setwd(dir.slides)

## ----one_sample, out.width="50%", fig.cap="Sélection d'un échantillon dans une population. "----
include_graphics("figures/population_one_sample.pdf") 

## ----some_samples, out.width="50%", fig.cap="Sélection d'un échantillon dans une population. "----
include_graphics("figures/population_some_samples.pdf")

## ----load_yeast_gene_lengths---------------------------------------------
## Read a GTF file
## Format specification: http://www.ensembl.org/info/website/upload/gff.html


## Replace this by the path of the file on your computer
gtf.file <- "/path/to_your_downloads/Saccharomyces_cerevisiae.R64-1-1.37.gtf"

## On my computer I build the path with the commands 
## - Sys.getenv(), to get my home directory
## - file.path(), to concatenate folder/subfolder names and the file name
gtf.file <- "../data/Saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.37.gtf"
features <- read.delim(gtf.file, comment.char = "#", sep="\t", header=FALSE, row.names=NULL)
names(features) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame", "attribute")
# nrow(features) ## Count feature number

## Select subset of features having "gene" as "feature" attribute
genes <- subset(features, feature=="gene")
## nrow(genes) ## Count the number of genes


## ----gene_length_histo, out.width="90%", fig.width=10, fig.height=4, fig.cap="Distribution of gene lengths for Saccharomyces cerevisiae. "----
par.ori <- par(no.readonly = TRUE)
par(mar = c(4.1,4.1,2.1,1.1))

## Add a column to the table with gene lengths
genes$length <- genes$end - genes$start +1
max.len <- max(genes$length)

## Select genes on the third chromosome
genes.III <- subset(genes, seqname == "III")
# View(genes.III)
par(mfrow=c(1, 2))

## Plot an histogram with gene lengths
hist(genes.III$length, 
     breaks=seq(from=0, to=max.len+100, by=100), 
     main="Chromosome III",
     xlab=NA, ylab="Number of genes", 
     col="#BBDDFF")

## Plot an histogram with gene lengths
hist(genes$length, 
     breaks=seq(from=0, to=max.len+100, by=100), 
     main="Full genome",
     xlab="Gene length (bp)", ylab="Number of genes", 
     col="#BBFFDD")
par(mfrow=c(1,1))

par <- par.ori


## ----rand_norm-----------------------------------------------------------
N <- 10000 ## Population size
mu0 <- 0 ## Mean for the random generator
sigma0 <- 1 ## Standard deviation for the random generator

## Generate the population
x <- rnorm(n=N, mean = mu0, sd = sigma0)

## Check the population mean

## Compute population mean and standard deviation
mu <- mean(x)

## Note: sd() computes a sample-based estimate of the population mean. Since we dispose here of the whole population, we "undo" the sampling correction (N-1). 
sigma <- sd(x) * (N-1)/N 



## ----mean_sampling-------------------------------------------------------
## Select random samples and compute their means
n <- 16 ## Sample size
R <- 10000 ## Repetitions of the sampling
sample.means <- replicate(
  n = R, 
  mean(sample(x, size = n, replace = FALSE)))

## Compute the mean and standard deviation of the sample means
m <- mean(sample.means)
s <- sd(sample.means) * (n-1) / n

## ----rand_norm_sampling_mean, fig.width=7, fig.height=6, fig.cap="Distribution des moyennes d'échantillon"----

## Compute the range and breaks of the histogram, with a symmetric display
xlim <- ceiling(max(abs(range(x)))) 
xbreaks <- seq(from=-xlim, to=xlim, by=0.1)

par(mfrow=c(2,1))
par(mar=c(4.1,4.1,2.1,1.1))
## Distribution of the population
hist(x, breaks=xbreaks, xlab = NA,
     col="#BBFFDD", main="Individus de la population", las=1)
legend("topright", cex=0.8,
       c(
  paste(sep="", "N = ", round(digits=3, N)), 
  paste(sep="", "mu = ", round(digits=3, mu0)), 
  paste(sep="", "sigma = ", round(digits=3, sigma0))
))

## Distribution of sample means
hist(sample.means, breaks=xbreaks, xlab="x",
     col="#BBDDFF", main="Moyennes d'échantillons", las=1)

legend("topright", cex=0.8,
       c(
  paste(sep="", "n (sample size) = ", round(digits=3, n)), 
  paste(sep="", "R (replicates) = ", round(digits=3, R)), 
  paste(sep="", "m (mean of the means) = ", round(digits=3, m)), 
  paste(sep="", "s (sd of the means) = ", round(digits=3, s))
))

par(mfrow=c(1,1))

## ----student_distrib, fig.width=7, fig.height=4, firg.cap="Distribution de Student. "----
## ##############################################################
##
## Draw a series of Student distributions with various degrees of
## freedom
##
## Author: Jacques van Helden
##
## Running this script requires to first run the script config.R
##
## Single-command execution:
## source(file.path(dir.R.files, 'student.R'))
##
## NOTE: THIS SCRIPT IS PROBABLY PARTLY REDUNDANT WITH
## golub/t-test_golub.R, BUT THERE ARE INTERESTING PLOTS HERE. TO
## CHECK.

x <- seq(from = -5, to=5, by=0.01)

in.colors <- TRUE ## Activate this to generate the color drawing for the book cover
freedom <- c(30,10,5,2,1)

if (in.colors) {
  palette <-   rainbow(10)
  bg <- '#000000'
  fg <- '#FFFFFF'
  file.prefix <- "student_distrib_cover"
} else {
  palette <- gray((0:16)/16)
  bg <- '#FFFFFF'
  fg <- '#000000'
  file.prefix <- "student_distrib"
}
# lty <- c(1,6,5,4,2,3,1,6,5,4,2,3)
lty <- rep(1, length.out = 12)

par(bg=bg)
par(fg=fg)

i <- 1
plot(x,dnorm(x),
     type="l",
     col=palette[i],
     lwd=2,
     lty=1,
     main="Student distributions",
     panel.first=grid(),
     xlab="x",
     ylab="density",
     col.axis=fg,
     col.lab=fg
     )
for (n in freedom) {
  i <- i+1
  lines(x,dt(x,n),
        type="l",
        col=palette[i],
        lwd=2,
        lty=lty[i]
        )
}

legend("topright",
       legend=c("normal",paste("student, df=",freedom)),
       col=palette[1:(length(freedom)+1)],
       lty=lty,
       lwd=2,
       bty="o",
       bg=bg)



