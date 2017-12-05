## ----include=FALSE, echo=FALSE, eval=TRUE--------------------------------
library(knitr)

options(width=300)
knitr::opts_chunk$set(
  fig.width = 7, fig.height = 5, 
  fig.align = "center", 
  fig.path = "figures/04_",
  size = "tiny", 
  echo = TRUE, eval=TRUE, 
  warning = FALSE, message = FALSE, 
  results = TRUE, comment = "")
# knitr::asis_output("\\footnotesize")

dir.main <- "~/stat1"
dir.slides <- file.path(dir.main, "slides")
setwd(dir.slides)

## ----geometric_PMF, fig.width=9, fig.height=4, echo=FALSE, fig.cap="**Probabilité de masse de la loi géométrique**. Gauche: ordonnée en échelle logarithmique. "----
################################################################
##
## Illustrations of the geometric distribution
##
## Running this script requires to first run the script config.R
##    source('http://pedagogix-tagc.univ-mrs.fr/courses/stat
##
## Single-command execution:
##   source(file.path(dir.R.files, 'geometric.R'))

# x11(width = 12, height = 15)

## Parameters
p <- 0.25      # Probability of success
n <- 30        # Waiting time (time of the first success)
x <- 0:n       # X values to be plotted

test.x <- 3    #  A particular X value where an arraw will be plotted


## Color specification (I cannot use colors for the book, but well for slides)
color.status <- "full"
if (color.status == "full") {
  plot.colors <- c('density'='blue',
              'CDF'='#00BB00',
              'dCDF'='purple'
              )
} else {
  plot.colors <- c('density'='black',
                   'CDF'='black',
                   'dCDF'='black'
  )
}

# ## Drawing parameters
par.ori <- par(no.readonly = TRUE)
par(mfrow=c(1,2))
par(las=1)
grid.color <- '#CCCCCC'

## grid sizes
x.grid <- 0:6*5
y.grid <- 0:20*0.05

## ##############################################################
## Waiting time before the first success in a Bernouli schema

################################################################
## Plot the probability mass function
plot(x - 0.5,
     dgeom(x,p),
     ylim=c(0,1),
     main="Geometric\nProbability mass function (PMF)",
     xlab='Waiting time',
     ylab='Probability: P(X=x)',
     panel.first=c(abline(v=x.grid,col=grid.color),
       abline(h=y.grid,col=grid.color)),
     col=plot.colors['density'],
     lwd=2, las=1,
     type='s'
     )
legend("topright", bty = "o", bg="white", 
       legend=paste(sep="", 'P(X=',test.x,') =', format(p)))

## Draw arrows to illustrate the relationship between density curve and probability
test.p <- dgeom(test.x,p)
arrows(test.x, 0,test.x,test.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
arrows(test.x, test.p,0,test.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
text(test.x,0, test.x,pos=4, cex=0.7)
text(0,test.p, round(test.p, digits=3),pos=1, cex=0.7)

################################################################
## Plot the probability mass function with logarithmic Y scale. Show an
## extended domain of X, to illustrate the capability of log scales to
## display small probabilities.
ext.x <- 0:(n+10)
plot(ext.x - 0.5,
     dgeom(ext.x,p),
     main=paste('PMF (log Y scale)'),
     xlab='Waiting time',
     ylab='Probability: P(X=x); log scale',
     ylim=c(min(dgeom(ext.x,p)),1),
     panel.first=grid(equilog=F,col=grid.color,lty='solid'),
     col=plot.colors['density'],
     lwd=2, las=1,
     type='s',
     log='y'
     )

## Draw arrows to illustrate the relationship between CDF and left tail probability
log.test.x = c(test.x, 29)
log.test.p <- round(dgeom(log.test.x, p),digits=c(3,5))
arrows(log.test.x, 1e-5,log.test.x,log.test.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
arrows(log.test.x, log.test.p,0,log.test.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
text(log.test.x,1e-5, log.test.x,pos=1, cex=0.7)
text(0,log.test.p, log.test.p,pos=1, cex=0.7)

par(mfrow=c(1,1))

## ----goemetric_CDF, fig.width=7, fig.height=5.5, echo=FALSE, fig.cap="**Queues et fonction de répartition de probabilité géométrique**. "----

par(mfrow=c(2,2))

################################################################
## Plot the probability mass function and highlight the left tail
left.tail.range <- 0:test.x
plot(x - 0.5,
     dgeom(x,p),
     ylim=c(0,1),
     main=paste('Left tail, X<=', test.x),
     xlab='Waiting time',
     ylab='Probability: P(X=x)',
     panel.first=c(abline(v=x.grid,col=grid.color),
       abline(h=y.grid,col=grid.color),
       rect(left.tail.range-0.5, 0, left.tail.range+0.5, dgeom(left.tail.range,p), density = NULL, angle = 45,
            col = '#BBBBBB', border = '#BBBBBB')
       ),
     col=plot.colors['density'],
     lwd=2, las=1,
     type='s'
     )
legend('topright',legend=paste('P(X<=',test.x,') = ',round(pgeom(test.x,p),digits=3),sep=''),bty='o', bg='#FFFFFF')
axis(1, at=test.x, labels=test.x,las=1,col.ticks='#888888')


################################################################
## Plot the probability mass function and highlight the right tail
right.tail.range <- test.x:n
plot(x - 0.5,
     dgeom(x,p),
     ylim=c(0,1),
     main=paste('Right tail, X>=', test.x),
     xlab='Waiting time',
     ylab='Probability: P(X=x)',
     panel.first=c(abline(v=x.grid,col=grid.color),
       abline(h=y.grid,col=grid.color),
       rect(right.tail.range-0.5, 0, right.tail.range+0.5, dgeom(right.tail.range,p), density = NULL, angle = 45,
            col = '#BBBBBB', border = '#BBBBBB')
       ),
     col=plot.colors['density'],
     lwd=2, las=1,
     type='s'
     )
legend('topright',legend=paste('P(X>=',test.x,') = ',round(pgeom(test.x-1,p,lower.tail=F),digits=3),sep=''),bty='o', bg='#FFFFFF')
axis(1, at=test.x, labels=test.x,las=1,col.ticks='#888888')

################################################################
## Plot the CDF function
plot(x - 0.5,
     pgeom(x,p),
     ylim=c(0,1),
     main=paste('Cumulative distribution function (CDF)'),
     xlab='Waiting time',
     ylab='CDF = P(X<=x)',
     panel.first=c(abline(v=x.grid,col=grid.color),
       abline(h=y.grid,col=grid.color)),
     col=plot.colors['CDF'],
     lwd=2, las=1,
     type='s'
     )
legend('bottomright',legend=paste('P(X<=',test.x,') = ',round(pgeom(test.x,p),digits=3),sep=''),bty='o', bg='#FFFFFF')

## Draw arrows to illustrate the relationship between CDF and left tail probability
left.tail.p <- pgeom(test.x,p)
arrows(test.x, 0,test.x,left.tail.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
arrows(test.x, left.tail.p,0,left.tail.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
text(x = test.x, y= 0, labels = test.x, pos=4, , cex=0.7)
text(0, left.tail.p, round(left.tail.p, digits=3), pos=3, , cex=0.7)


################################################################
## Plot the dCDF function
plot(x - 0.5,
     pgeom(x-1,p,lower.tail = F), ## We use x-1 to obtain the inclusive dCDF rather than the default exclusive one
     ylim=c(0,1),
     main=paste('Decreasing CDF (dCDF)'),
     xlab='Waiting time',
     ylab='dCDF = P(X>=x)',
     panel.first=c(abline(v=x.grid,col=grid.color),
       abline(h=y.grid,col=grid.color)),
     col=plot.colors['dCDF'],
     lwd=2, las=1,
     type='s'
     )
legend('topright',legend=paste('P(X>=',test.x,') = ',round(pgeom(test.x-1,p,lower.tail=F),digits=3),sep=''),bty='o', bg='#FFFFFF')

## Draw arrows to illustrate the relationship between dCDF and right tail probability
right.tail.p <- pgeom(test.x-1,p,lower.tail=F)
arrows(test.x, 0,test.x,right.tail.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
arrows(test.x, right.tail.p,0,right.tail.p,col='#888888',length=0.1,angle=25,code=2,lwd=2)
text(test.x,0, test.x,pos=4, cex=0.7)
text(0,right.tail.p, round(right.tail.p, digits=3),pos=3, cex=0.7)

## Show that the sum of CDF and dCDF differ from 1
## print(c(dgeom(test.x, p), left.tail.p, right.tail.p, right.tail.p + left.tail.p),digits=3)
par(par.ori)
par(mfrow=c(1,1))

## ----binomial_i-shaped, fig.width=9, fig.height=4, echo=FALSE, fig.cap="Distribution binomiale en forme de i.  "----


## Drawing parameters
par.ori <- par(no.readonly = TRUE)
par(mfrow=c(1,2))
grid.color <- '#CCCCCC'


## color specification (actually I don't use colors for the book
if (color.status == "full") {
  plot.col <- c('probability'='blue',
                'CDF'='darkgreen',
                'dCDF'='purple',
                'grid'='#CCCCCC'
                )
} else {
  plot.col <- c('probability'='black',
                'CDF'='black',
                'dCDF'='black',
                'grid'='#CCCCCC'
                )
}
line.types <- c(probability="solid",
                CDF="solid",
                dCDF="solid",
                grid="solid")

## Drawing parameters
par.ori <- par(no.readonly = TRUE)
par(las=1)

#### initialize parameters
p.values <- c(0.02,0.1,0.5,0.98) ## Success probabilities
n <- 20 ## Number of trials
x.display <- 20 ## Max value to display on the X axis
x <- c(0:n, n) ## Add an "n" at the end in order to have the last horizontal bar in the plot
x.shifted <- (0:(n+1))-0.5
x.grid <- x
y.grid <- seq(from=0,to=1,by=0.2)
  

#### Binomial functions
p <- 0.02
binomial.mean <- p*n

xmax <- 5 + 4*binomial.mean

plot(x.shifted,
     dbinom(x,n,p),
     main=paste("Binomial probability (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X=x)",
     col=plot.col["probability"],
     lty=line.types["probability"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)

plot(x.shifted,
     pbinom(x,n,p),
     main=paste("CDF (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X <= x)",
     col=plot.col["CDF"],
     lty=line.types["CDF"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)
par(par.ori)
par(mfrow=c(1,1))

## ----binomial_distrib_bell-shaped, fig.width=9, fig.height=4, echo=FALSE, fig.cap="Distribution binomiale en forme de cloche asymétrique.  "----

## Drawing parameters
par(mfrow=c(1,2))
par(las=1)

################################################################
#
# Binomial series
#


#### Binomial functions
p <- 0.25
binomial.mean <- p*n

xmax <- 5 + 4*binomial.mean

plot(x.shifted,
     dbinom(x,n,p),
     main=paste("Binomial probability (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X=x)",
     col=plot.col["probability"],
     lty=line.types["probability"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)

plot(x.shifted,
     pbinom(x,n,p),
     main=paste("CDF (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X <= x)",
     col=plot.col["CDF"],
     lty=line.types["CDF"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)
par(par.ori)
par(mfrow=c(1,1))

## ----binomial_distrib_symmetric-bell, fig.width=9, fig.height=4, echo=FALSE, fig.cap="Distribution binomiale en forme de cloche symétrique (p=0.5). "----

## Drawing parameters
par(mfrow=c(1,2))
par(las=1)

p <- 0.5
binomial.mean <- p*n

xmax <- 5 + 4*binomial.mean

plot(x.shifted,
     dbinom(x,n,p),
     main=paste("Binomial probability (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X=x)",
     col=plot.col["probability"],
     lty=line.types["probability"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)

plot(x.shifted,
     pbinom(x,n,p),
     main=paste("CDF (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X <= x)",
     col=plot.col["CDF"],
     lty=line.types["CDF"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)
par(par.ori)
par(mfrow=c(1,1))

## ----binomial_distrib_j-shaped, fig.width=9, fig.height=4, echo=FALSE, fig.cap="Distribution binomiale en forme de j.  "----

## Drawing parameters
par(mfrow=c(1,2))
par(las=1)

p <- 0.98
binomial.mean <- p*n

xmax <- 5 + 4*binomial.mean

plot(x.shifted,
     dbinom(x,n,p),
     main=paste("Binomial probability (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X=x)",
     col=plot.col["probability"],
     lty=line.types["probability"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)

plot(x.shifted,
     pbinom(x,n,p),
     main=paste("CDF (p=",format(p),", n=", format(n), ")"),
     ylim=c(0,1),
     xlab="X (successes)",
     ylab="P(X <= x)",
     col=plot.col["CDF"],
     lty=line.types["CDF"],
     type="s",
     lwd=2, las=1,
     panel.first=c(abline(v=x.grid,col=plot.col['grid'],lty=line.types["grid"]),
                   abline(h=y.grid,col=plot.col['grid'],lty=line.types["grid"]))
)
par(par.ori)
par(mfrow=c(1,1))

## ----echo=FALSE----------------------------------------------------------
oligo.freq <- read.table("../data/Saccharomyces_cerevisiae/oligo_freq/3nt_genomic_Saccharomyces_cerevisiae-ovlp-1str.tab", sep="\t", row.names = NULL)
colnames(oligo.freq) <- c("sequence", "frequency", "occurrences")
oligo.freq$frequency <- signif(digits=3, oligo.freq$frequency)

row.names(oligo.freq) <- oligo.freq$sequence

#oligo.freq["...",] <- c("...", "...", "...")

selected.oligos <- c("AAA", "ATG", "TAA", "TAG", "TGA")

kable(data.frame(oligo.freq[selected.oligos, ]), row.names = FALSE)
#print(data.frame(oligo.freq[selected.oligos, ]))

