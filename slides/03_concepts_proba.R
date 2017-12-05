## ----include=FALSE, echo=FALSE, eval=TRUE--------------------------------
options(width=300)
knitr::opts_chunk$set(
  fig.width = 7, fig.height = 5, 
  fig.path='figures',
  fig.align = "center", 
  size = "tiny", 
  echo = TRUE, eval=TRUE, 
  warning = FALSE, message = FALSE, 
  results = TRUE, comment = "")
# knitr::asis_output("\\footnotesize")


## ----echo=FALSE, fig.height=3, fig.width=10, fig.cap="Fréquences de A lors du tirage (avec remise) de positions aléatoires dans le génome de *Mycoplasma genitalium*. "----
################################################################
## Illustration of the frequential definition of probability.
##
## We generate a fake genomic sequence having the same nucleotide 
## composition as Mycoplasma genitalium, and perform a random sampling.  


## Parameters for the sampling of nucleotides in the Mycoplasma genome

## Instantiate a vector with the count of occurrences per residue
## in the whole genome of Mycoplasma genitalium.
nt.counts.mycoplasma <- c("A" = 200543,
                          "C" = 91524,
                          "G" = 92312,
                          "T" = 195695)
genome.size.mycoplasma <- sum(nt.counts.mycoplasma)

## Compute genome size
L <- sum(nt.counts.mycoplasma)  ## Genome length
N <- 1.0e+6           ## Samplin size
x.values <- c(1:100,10*(11:100),100*(11:100),1000*(11:100),10000*(11:100)) ## Values to be plotted (plotting the 10^6 values would generate a huge file where most points are not even visible)


## For the sake of storage economy, rather than analyzing the actual
## genome sequence, we generate a fake genome of the same size as 
## Mycoplasma genitalium, and with the same nucleotide frequencies 
## (but where residues are sorted alphabetically). Since the sampling 
## is done in a position-independent way this does not affect the result.
genome <- rep(names(nt.counts.mycoplasma), nt.counts.mycoplasma)

## Calculate the probability of the A residue
p.A <- nt.counts.mycoplasma["A"]/genome.size.mycoplasma


## Generate four plots illustrating the convergence of the realization frequency of an event (sampling of nucleotide A in Myciplasma genome) towards the probability of this event (frequency of this nucleotide in the whole genome).
par(mfrow=c(1,3)) ## Four panels per figure

## Perform 4 independent trials, to give an idea of the variability of the initial frequencies
for (i in 1:3) {
  
  ## Sample residues in the fake genome
  res.sample <- sample(genome,size=N,replace=T)
  
  ## Count the cumulative sum of adenine residues
  A.cumsum <- cumsum(res.sample == "A")
  A.cumfreq <- A.cumsum/(1:N)
  
  plot(x.values, A.cumfreq[x.values],
       col="black",
       log="x",
       type="l",
       main=paste("Series", i),
       xlab="Sample size",
       ylab="Frequency of A",
       panel.first=c(grid(col="black"),
         abline(h=p.A,col="#444444", lwd=2,lty="dashed")),
       ylim=c(0,1), lwd=2
       )
  
}
par(mfrow=c(1,1)) ## Restore default plot parameters


