Univariate meta-analysis
================

<br>

**Aim**: To estimate fixed-effects and random-effects models for binary data in a univariate meta-analysis.

**Data**: Crime outcome data from 7 studies evaluating the effect of "Scared Straight" programme on levels of reoffending (Petrosino et al., 2013).

**Outputs**: The data are dichotomous so odds-ratios and 95% CIs will be reported.

#### Examine the data

``` r
print(df)
```

    ##             study year event.e n.e event.c n.c
    ## 1      Finkenauer 1982      19  46       4  35
    ## 2          GERPDC 1979      16  94       8  67
    ## 3           Lewis 1983      43  53      37  55
    ## 4 Michigan D.O.C. 1967      12  28       5  30
    ## 5       Orchowsky 1981      16  39      16  41
    ## 6        Vreeland 1981      14  39      11  40
    ## 7      Yarborough 1979      27 137      17  90

-   *event.e* refers to the number of events in experimental group.
-   *n.e refers* to the number of observations in experimental group.
-   *event.c* refers to the number of events in control group.
-   *n.c* refers to the number of observations in control group

#### Load the [meta](https://cran.r-project.org/web/packages/meta/index.html) package created by Guido Schwarzer

``` r
library(meta)
```

#### Estimate the odds ratio for the first study

``` r
study1 <- metabin(event.e, n.e, event.c, n.c,
             data = df, 
             sm = "OR", 
             studlab = paste(study, year), 
             subset = study == "Finkenauer",
             title = "Scared Straight")
print(study1, digits=2)
```

    ## Review:     Scared Straight
    ##    OR        95%-CI    z  p-value
    ##  5.45 [1.65; 18.02] 2.78   0.0054
    ## 
    ## Details:
    ## - Inverse variance method

In the Finkenauer (1982) study, 19 out of 46 participants (41.3%) in the intervention group who were exposed to the "Scared Straight" programme reoffended at follow-up, compared with 4 out of 35 in the control group (11.4%). This was a statistically significant difference since the confidence interval doesn't include 1. This single study suggests that the "Scared Straight" programme increases the risk of reoffending.

#### Estimate odds ratios for each study and produce a forest plot

``` r
m <- metabin(event.e, n.e, event.c, n.c,
             data = df, 
             sm = "OR", 
             studlab = paste(study, year), 
             title = "Scared Straight")
forest(m, layout="revman5", comb.random=FALSE)
```

![](https://github.com/rcatlord/reviewing/blob/master/meta-analysis/forest_plot.png)

Only 2 out of 7 studies produced a statistically significant result (Finkenauer, 1982 and Michigan D.O.C., 1967). However, the pooled estimate is statically significant. The odds ratio of reoffending amongst those exposed to the "Scared Straight" programme compared with the control group is 1.68 which is statistically signifiant because the 95% confidence interval of (1.20, 2.36) using a fixed-effects model does not contain the value 1. This suggests that participants of the "Scared Straight" programme are 68% more likely to reoffend than those not exposed to it. "The intervention on average is more harmful to juveniles than doing nothing" (Petrosino et al. 2003: 41).

Both fixed effect and random effects models are calculated. The *p*-value (*p* = 0.2039) for the Higgins' *I*<sup>2</sup> test was was greater than an a *α* confidence level of 0.05 which suggests that a fixed effects model is appropriate for the meta-analysis because we cannot reject the null hypothesis that there is no study heterogeneity.[1] If heterogeneity between studies was present then a random effects model would be preferred.

#### References

Petrosino A., Turpin-Petrosino C., Hollis-Peel M.E., & Lavenberg J.G. (2013) ['Scared Straight' and other juvenile awareness programs for preventing juvenile delinquency (Review)](https://www.campbellcollaboration.org/media/k2/attachments/Petrosino_Scared_Straight_Update.pdf). Cochrane Database of Systematic Reviews 2013, Issue 4.

[1] A Higgins' *I*<sup>2</sup> of 29.4% is borderline 'Moderate' heterogeneity since 'Low' is between 0-30% and 'Moderate' is between 30-60%.
