# CHAP Survey Weights

In the initial stages of the Combatting Household Air Pollution (CHAP) project, a household needs assessment was conducted to learn more about Ghanaians fuel consumption, cooking habits, household structure, and economic behavior, amongst other things. In order to obtain nationally representative statistics, the sampling design followed a multistage, stratified and cluster sampling strategy. Due to documentation issues related to stratification on locality and cluster population sizes, the survey weights (obtained through calculating the inverse probability of selecting a household) were not fully trustworthy and did not align with census results for a number of variables. 

This led me to explore alternative approaches to survey weighting, including iterative proportional fitting (raking). Raking is the post-stratification procedure of adjusting sample weights to better match known population totals. With raking, a researcher chooses a set of variables where the population distribution is known, and the procedure iteratively adjusts the weight for each case until the sample distribution aligns with the known population for those variables. This allows for improved representatieness and accuracy. 

The CHAP_survey_weights repository contains a number of R markdown documents related to various explorations of raking for the household needs assessment survey. 

## Rake_weights_explore
This document contains my replication of calculating the base weights (inverse probability of selection) and initial exploration of the raking process. All analyses were conducted in the survey package in R. 

## anesrake_version
This markdown contains a version of the raking process that uses the anesrake pakcage in R. This is a very similar process, but uses population proportions rather than population totals to rake. The underlying equation behind the iterative fitting is also slighlty different, but led to very similar predictions. 

## raking_populations
This document was created as a cleaner version of the Rake_weights_explore markdown, reorganized so all of the population totals were grouped together at the beginning of the doucment before diving into each raking method. 

## rake_sensitivity_analysis 
This document was created to explore how different groupings of regions (which needed to be collapsed due to small cell counts) affected the raking results. This contains the most up to date versions of the raking methods. 

