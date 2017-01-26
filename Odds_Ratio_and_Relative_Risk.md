Odds Ratio and Relative Risk
================

**Study**: Finckenauer (1982)
**Methods**: Random assignment
**Participants**: 81 children and young adults aged 11-18 years of which 50% had previously offended
**Intervention**: 3 hour rap session with ‘Lifers’ in Rahway State Prison in New Jersey
**Outcome**: Percentage of new complaints, contacts or court appearances after 6 month follow-up period

<table class="table table-condensed dummy">
<caption>
Nomenclature for 2 x 2 table of outcome by treatment
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
Events
</th>
<th style="text-align:left;">
Non-Events
</th>
<th style="text-align:left;">
N
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Treatment
</td>
<td style="text-align:left;">
a
</td>
<td style="text-align:left;">
b
</td>
<td style="text-align:left;">
n1
</td>
</tr>
<tr>
<td style="text-align:left;">
Control
</td>
<td style="text-align:left;">
c
</td>
<td style="text-align:left;">
d
</td>
<td style="text-align:left;">
n2
</td>
</tr>
</tbody>
</table>
``` r
# Number of participants who committed new offences 6 months after the intervention: a
a <- 19
# Number of participants who committed new offences 6 months after 'business as usual': b
b <- 4
# Number of participants who did not commit new offences 6 months after the intervention: c
c <- 27
# Number of participants who did not commit new offences 6 months after 'business as usual': d
d <- 31
```

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
``` r
# Total sample
a+c+b+d
```

    ## [1] 81

``` r
# Total for the intervention: a+c
a+c
```

    ## [1] 46

``` r
# Total for 'business as usual': b+d
b+d
```

    ## [1] 35

``` r
# Percentage of the treatment group that committed new offences: a/(a+c)*100
round(a/(a+c)*100,2)
```

    ## [1] 41.3

``` r
# Percentage of the control group that committed new offences: b/(b+d)*100
round(b/(b+d)*100,2)
```

    ## [1] 11.43

``` r
# Odds of the outcome in the treatment group: a/c
round(a/c, 2)
```

    ## [1] 0.7

``` r
# Odds of the outcome in the control group: b/d
round(b/d, 2)
```

    ## [1] 0.13

``` r
# Odds ratio for the outcome comparing treatment with control: (a/c)/(b/d)
round((a/c)/(b/d), 2)
```

    ## [1] 5.45

``` r
# Risk of the outcome in the treatment group: a/(a+c)
round(a/(a+c), 2)
```

    ## [1] 0.41

``` r
# Risk of the outcome in the control group: b/(b+d)
round(b/(b+d),2)
```

    ## [1] 0.11

``` r
# Relative risk comparing treatment with control: (a×(b+d))/(b×(a+c))
round((a*(b+d))/(b*(a+c)),2)
```

    ## [1] 3.61
