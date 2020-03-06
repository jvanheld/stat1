---
title: 'Use case: leukemia signatures (Den Boer, 2009)'
author: "Jacques van Helden"
date: '2020-03-06'
output:
  slidy_presentation:
    fig_caption: yes
    fig_height: 6
    fig_width: 7
    highlight: tango
    incremental: yes
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
  pdf_document:
    fig_caption: yes
    highlight: zenburn
    toc: yes
    toc_depth: 3
  html_document:
    fig_caption: yes
    highlight: zenburn
    theme: cerulean
    toc: yes
    toc_depth: 3
    toc_float: yes
font-import: http://fonts.googleapis.com/css?family=Risque
subtitle: Analyse Statistique des données Génomiques (ASG)
font-family: Garamond
transition: linear
---



## Study case

We present here a dataset that will be used as study case to apply different approaches of multivariate analysis:

- data exploration
- multidimensional scaling
- differential analysis
- clustering (unsupervised classification)
- supervised classification

**Reference:** Den Boer ML *et al.* (2009). A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol. 2009 10:125-34. [[doi: 10.1016/S1470-2045(08)70339-5](http://doi.org/10.1016/S1470-2045(08)70339-5)], 
[[PMID 19138562](https://www.ncbi.nlm.nih.gov/pubmed/19138562)]. Data available at Gene Expression Omnibus, series [[GSE13425](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425)]


## Identification of signatures for subtypes of leukemia

<div class="figure" style="text-align: center">
<img src="images/Den_Boer_2009_Fig1_signature_identification.png" alt="Figure 1 from Den Boer et al. (2009). " width="40%" height="40%" />
<p class="caption">Figure 1 from Den Boer et al. (2009). </p>
</div>

## Hierarchical clustering of genes and samples

<div class="figure" style="text-align: center">
<img src="images/Den_Boer_2009_Fig2_hierarchical_clustering.png" alt="Figure 2 from Den Boer et al. (2009). " width="70%" height="70%" />
<p class="caption">Figure 2 from Den Boer et al. (2009). </p>
</div>

## Survival curves


<div class="figure" style="text-align: center">
<img src="images/Den_Boer_2009_Fig3_survival.png" alt="Figure 3 from Den Boer et al. (2009). " width="80%" height="80%" />
<p class="caption">Figure 3 from Den Boer et al. (2009). </p>
</div>


