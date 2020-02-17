## Analysis of k-mer distributions in promoter sequences
##
## Author: Jacques van Helden
## Date: 2020-02-17


#### Create a working directory ####

## Get the current working directory
getwd()


## Assign a value (the home directory to a variable (named my.home)
my.home = "~" ## BAD, DON'T DO IT if you prefer for me to stay calm
my.home <- "~" ## GOOD. Do it!

## Print on the screen the content of  a variable
print(my.home)
length(my.home)

## Print the type of content of the variable my.home
class(my.home)

## Create a vector of numbers
x <- c(1, 7, -3, 2)
print(x)

x <- seq(from = 10, to = 157, by=2)
print(x)

## List files in my home directory
list.files(my.home)

## Specify the organism of interest
org <- "Homo_sapiens"

##  Define a working directory for the practical
work.dir <- paste(sep = "/", my.home, "STAT2_CMB_practicals", "kmer_distrib", org)
print(work.dir)

## Cleaner way to define a path, whcih will be suitable on all operating systems
work.dir <- file.path(my.home, "STAT2_CMB_practicals", "kmer_distrib", org)

## Check the working directory
print(work.dir)

list.files(work.dir)

## Create the working directory
dir.create(work.dir, recursive = TRUE, showWarnings = FALSE)
list.files(work.dir)

## Set this directory as your actual working directory
setwd(work.dir)

## Check it the current working directory is the one we created
getwd()


#### Download k-mer counts from RSAT  ####



