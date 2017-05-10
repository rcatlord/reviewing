# What is the difference in reoffending rates between a treatment group with a reoffending rate of 45% and 
# an untreated control group with 50%?

# Percentage points
# ANSWER: a reduction of 5 percentage points

# percentage point change = baseline rate – intervention group rate
50-45

# Percentage change
# ANSWER: a 10% reduction

# percentage change = (baseline rate – intervention group rate) ÷ baseline rate x 100
(50-45)/50*100

## represent a 10% reduction in reoffending from a base rate of 50% as a phi coefficient
library(psych)
phi(c(45,55,50,50))

# What is the percentage change in the recidivism rate for the intervention with a control recidivism rate of 0.50 
# that corresponds to an effect size of -0.05?


## Odds ratios
# With a comparison reoffending rate set at 50%, what is the reoffending
# rate in the treatment group with an odds ratio of x?

(0.99*0.4)/(1+0.99*0.4-0.4)
round(19/46*100, 1)
