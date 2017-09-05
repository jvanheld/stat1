################################################################
## Extract the code of this markdown file
library(knitr)

dir.course <- "~/stat1"
dir.practicals <- file.path(dir.course, "practicals")
dir.slides <- file.path(dir.course, "slides")

export.dir <- dir.slides
for (export.dir in c(dir.slides, dir.practicals)) {
  Rmd.files <- list.files(path=export.dir, pattern="*.Rmd", recursive = TRUE, full.names = FALSE)
  setwd(export.dir)
  
  for (md.file in Rmd.files) {
    R.file <- sub(pattern=".Rmd$", replacement = ".R", x = md.file)
    purl(md.file, output=R.file, quiet=TRUE)
    message("Extracted R code: ", R.file)
  }
  
}
