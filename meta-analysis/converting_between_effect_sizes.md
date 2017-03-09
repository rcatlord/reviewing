Converting between effect sizes
================

The following effect size conversions use formulae derived from Lipsey & Wilson (2001) and Borenstein, Hedges, Higgins, & Rothstein (2009) and some R code adapted from Polanin & Snilstveit (2016).

#### The data

The effect size conversions use data from an experimental trial of the effect of 'Scared Straight' programmes (Finckenauer 1982) on levels of reoffending as reported in Petrosino *et al.* (2013).

<table>
<caption>
2 x 2 table (Finckenauer 1982)
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
Reoffended
</th>
<th style="text-align:right;">
Not reoffended
</th>
<th style="text-align:right;">
N
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Treatment
</td>
<td style="text-align:right;">
19
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
46
</td>
</tr>
<tr>
<td style="text-align:left;">
Control
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:right;">
35
</td>
</tr>
</tbody>
</table>
#### Calculate the Odds ratio (OR)

``` r
OR <- (19/27)/(4/31)
round(OR, 2)
```

    ## [1] 5.45

``` r
# calculate variance of log odds ratio
V_log_OR <- (1/19 + 1/4 + 1/27 + 1/31)
round(V_log_OR, 2)
```

    ## [1] 0.37

``` r
# calculate 95% confidence intervals of OR
SE_log_OR <- sqrt(V_log_OR)
CI_lower_log_OR <- log(OR) - 1.96*SE_log_OR
CI_upper_log_OR <- log(OR) + 1.96*SE_log_OR
CI_lower_OR <- exp(CI_lower_log_OR)
round(CI_lower_OR, 2)
```

    ## [1] 1.65

``` r
CI_upper_OR <- exp(CI_upper_log_OR)
round(CI_upper_OR, 2)
```

    ## [1] 18.02

#### Convert Odds ratio (OR) to Risk ratio (RR)

``` r
# the Odds ratio (OR) is equal to 5.45
OR <- 5.453704
p <- 4 / 35 # where p = the risk in the control group (i.e. n events / N)
RR <- OR / (1 - p + (p * OR))
round(RR, 2)
```

    ## [1] 3.61

#### Convert Odds ratio (OR) to Standardised mean difference (d)

``` r
# the Odds ratio (OR) is equal to 5.453704
logOR <- log(5.453704)
d <- logOR*(sqrt(3)/pi)
round(d, 2)
```

    ## [1] 0.94

``` r
# the variance of the odds ratio is equal to 0.3719267
V_logOR <- 0.3719267
V_d <- V_logOR * (3/(pi^2))
round(V_d, 2)
```

    ## [1] 0.11

#### Convert Standardised mean difference (d) to Odds ratio (OR)

``` r
# the Standardised mean difference (d) is equal to 0.9352161
logOR <- 0.9352161*(pi/sqrt(3))
round(exp(logOR), 2)
```

    ## [1] 5.45

``` r
# the variance of d is equal to 0.1130522
V_OR <- 0.1130522*((pi^2)/3)
round(V_OR, 2)
```

    ## [1] 0.37

#### Convert Standardised mean difference (d) to Correlation coefficient (r)

``` r
# the Standardised mean difference (d) is equal to 0.9352165
d <- 0.9352165
a <- ((35+46)^2)/(35*46) # a correction factor when the number of cases in the control group does not equal the treatment
r <- d/sqrt(((d^2)+a))
round(r, 2)
```

    ## [1] 0.42

``` r
V_d <- 0.113044
V_r <- ((a^2)*V_d)/(((d^2)+a)^3)
round(V_r, 2)
```

    ## [1] 0.02

#### References

Borenstein, M., Hedges, L. V., Higgins, J. P. T., & Rothstein, H. R. (2009). Introduction to Meta-Analysis, [Chapter 7: Converting Among Effect Sizes](https://www.meta-analysis.com/downloads/Meta-analysis%20Converting%20among%20effect%20sizes.pdf). Chichester, West Sussex, UK: Wiley.

Lipsey, M. W., & Wilson, D. B. (2001). Practical meta-analysis. Thousand Oaks, CA: Sage.

Petrosino A., Turpin-Petrosino C., Hollis-Peel M.E., & Lavenberg J.G. (2013) ['Scared Straight' and other juvenile awareness programs for preventing juvenile delinquency](http://onlinelibrary.wiley.com/doi/10.1002/14651858.CD002796.pub2/full) (Review). Cochrane Database of Systematic Reviews 2013, Issue 4.

Polanin, J. R., Snilstveit, B. (2016). [Campbell Methods Policy Note on Converting Between Effect Sizes](https://www.campbellcollaboration.org/images/library/converting_between_effect_sizes.pdf) (Version 1.1, updated December 2016). Oslo: The Campbell Collaboration. DOI: 10.4073/cmpn.2016.3
