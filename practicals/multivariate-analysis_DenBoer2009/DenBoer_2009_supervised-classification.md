---
title: "Practical -- Supervised classification -- Microarrays"
author: "Jacques van Helden"
date: "2020-03-19"
output:
  slidy_presentation:
    fig_caption: yes
    fig_height: 6
    fig_width: 7
    highlight: tango
    incremental: no
    keep_md: yes
    smaller: yes
    theme: cerulean
    toc: yes
    widescreen: yes
  ioslides_presentation:
    colortheme: dolphin
    fig_caption: yes
    fig_height: 6
    fig_width: 7
    fonttheme: structurebold
    highlight: tango
    smaller: yes
    toc: yes
    widescreen: yes
  beamer_presentation:
    colortheme: dolphin
    fig_caption: yes
    fig_height: 6
    fig_width: 7
    fonttheme: structurebold
    highlight: tango
    incremental: no
    keep_tex: no
    slide_level: 2
    theme: Montpellier
    toc: yes
  word_document:
    toc: yes
    toc_depth: '3'
  html_document:
    code_folding: hide
    fig_caption: yes
    highlight: zenburn
    self_contained: no
    theme: cerulean
    toc: yes
    toc_depth: 3
    toc_float: yes
  pdf_document:
    fig_caption: yes
    highlight: zenburn
    toc: yes
    toc_depth: 3
font-import: http://fonts.googleapis.com/css?family=Risque
subtitle:  STAT2
font-family: Garamond
transition: linear
---




## Introduction

In  this practical we will define a pipeline to run supervised classification on a multivariate dataset (transcriptome microarrays of leukemia from Den Boer 2009). 




## Study case

**Reference:** Den Boer ML *et al.* (2009). A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol. 2009 10:125-34. 

- **DOI**: [[doi: 10.1016/S1470-2045(08)70339-5](http://doi.org/10.1016/S1470-2045(08)70339-5)]
- **Pubmed**: [[PMID 19138562](https://www.ncbi.nlm.nih.gov/pubmed/19138562)]. 
- **Raw data** available at Gene Expression Omnibus, series [[GSE13425](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425)]
- **Preprocessed data**: <https://github.com/jvanheld/stat1/tree/master/data/DenBoer_2009>.

## Data pre-processing

The raw microarray data has been pre-processed in order to dispose of a ready-to-use dataset. pre-processing included 

- filtering of barely detected or poorly expressed genes, 
- log2 transformation to normalise the raw measurements
- between-sample standardisation to enable comparison between the different samples.

## Re-loading the pre-proocessed data

The detailed procedure to build the data set from tab-delimited files was described in the practical [**Data loading and exploration**](DenBoer_2009_load-and-explore_solutions.html).

At the end of this practical we saved a memory image with the data. We provide hereby a few lines of code that should enable you to reload this data. 





