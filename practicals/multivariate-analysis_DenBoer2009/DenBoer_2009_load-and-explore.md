---
title: "Practical -- Microarray analysis -- Data loading and exploration"
author: "Jacques van Helden"
date: "2020-03-06"
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
  html_document:
    code_folding: hide
    fig_caption: yes
    highlight: zenburn
    self_contained: no
    theme: cerulean
    toc: yes
    toc_depth: 3
    toc_float: yes
  word_document:
    toc: yes
    toc_depth: '3'
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
  pdf_document:
    fig_caption: yes
    highlight: zenburn
    toc: yes
    toc_depth: 3
font-import: http://fonts.googleapis.com/css?family=Risque
subtitle:  (STAT2)
font-family: Garamond
transition: linear
---




## Introduction

In this practical, we will load a dataset that will be used as study case to apply different approaches of multivariate analysis:

- data exploration
- multidimensional scaling
- differential analysis
- clustering (unsupervised classification)
- supervised classification

## Study case

**Reference:** Den Boer ML *et al.* (2009). A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol. 2009 10:125-34. [[doi: 10.1016/S1470-2045(08)70339-5](http://doi.org/10.1016/S1470-2045(08)70339-5)], 
[[PMID 19138562](https://www.ncbi.nlm.nih.gov/pubmed/19138562)]. Data available at Gene Expression Omnibus, series [[GSE13425](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425)]

## Data pre-processing

The raw microarray data has been pre-processed in order to dispose of a ready-to-use dataset. pre-processing included 

- filtering of barely detected or poorly expressed genes, 
- log2 transformation to normalise the raw measurements
- between-sample standardisation to enable comparison between the different samples.

## Availability of the pre-processed data


The preprocessed data is available here:  <https://github.com/jvanheld/stat1/data/DenBoer_2009>.

It contains the following files.

| File | Contents | Structure |
|--|--|--|
| [GSE13425_AMP_Whole.tsv.gz](GSE13425_AMP_Whole.tsv.gz) | Normalised microarray data | Tab-delimited file with one row per gene and one column per patient |
