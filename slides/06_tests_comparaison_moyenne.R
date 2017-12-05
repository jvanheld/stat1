## ----include=FALSE, echo=FALSE, eval=TRUE--------------------------------
library(knitr)
library(diagram) ## For flowcharts


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

## ----mean_compa_flowchart, fig.width=7, fig.height=6---------------------
# creates an empty plot
openplotmat(main="Choice of a mean comparison test")

# create the coordinates
pos <- coordinates(c(1, 2, 2, 3))
pos[2,1] <- (pos[6,1] + pos[7, 1])/2
pos[4,1] <- (pos[6,1] + pos[7, 1])/2
pos[3,1] <- pos[8,1]
pos[5,1] <- pos[8,1]
pos.labels <- c("normality ?", 
               "Parametric", "Large samples ?", 
               "Equal var ?", "Non-parametric",
               "Student", "Welch", "Wilcoxon\nMann-Whitney")
nb.nodes <- nrow(pos)
question.nodes <- c(1, 3, 4)
  
fromto <- matrix(ncol = 2, byrow = TRUE,
                 data = c(1, 2, # 1
                          1, 3, # 2
                          3, 2, # 3
                          2, 4, # 4
                          4, 6, # 5
                          4, 7, # 6
                          3, 5, # 7
                          5, 8  # 8
                          ))
yes.arrows <- c(1,3,5)
no.arrows <- c(2,6,7)


nb.arrows     <- nrow(fromto)
arrpos <- matrix(ncol = 2, nrow = nb.arrows)
for (i in 1:nb.arrows) {
  if (i %in% yes.arrows) {
    arrow.color <- "#00BB00"
  } else if (i %in% no.arrows) {
    arrow.color <- "red"
  } else {
    arrow.color <- "black"
  }
 arrpos[i, ] <- straightarrow (
   from = pos[fromto[i, 1], ],
   to = pos[fromto[i, 2], ],
   lwd = 2, arr.pos = 0.5,
   arr.length = 0.25, lcol = arrow.color)
  if (i %in% yes.arrows) {
    text(arrpos[i, 1] + 0.02, arrpos[i, 2] - 0.03, "yes", col = "#00BB00")
  } else if (i %in% no.arrows) {
    text(arrpos[i, 1] + 0.02, arrpos[i, 2] - 0.03, "no", col = "red")
  }
}

for (i in 1:nb.nodes) {
  if (i %in% question.nodes) {
    ## Draw diamons for choices
    textdiamond(
      mid = pos[i,], radx = 0.2, rady = 0.05, 
      lab = pos.labels[i], cex = 1, 
      lcol="orange", lwd=2)
    
  } else {
    ## Draw ellipses for operations 
    textellipse(
      mid = pos[i,], radx=0.15, rady=0.05,
      lab=pos.labels[i])
  }
}
# text(arrpos[2, 1] + 0.05, arrpos[2, 2], "no", col = "red")
# text(arrpos[4, 1] - 0.05, arrpos[4, 2], "yes", col = "#00BB00")
# text(arrpos[5, 1] + 0.05, arrpos[5, 2], "no", col = "red")
# text(arrpos[4, 1] - 0.05, arrpos[4, 2], "yes", col = "#00BB00")
# text(arrpos[5, 1] + 0.05, arrpos[5, 2], "no", col = "red")



