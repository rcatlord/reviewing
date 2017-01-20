# Convert standardised mean difference (d) to log odds ratio using Hasselblad and Hedges logit method
# http://handbook.cochrane.org/chapter_9/9_4_6_combining_dichotomous_and_continuous_outcomes.htm

# d = -0.155
# SE = 0.046

# log odds ratio
lnOR <- -0.155*(pi/sqrt(3))
# transform log odds using the exponent
exp(lnOR)

library(esc)
esc_d2logit(d = -0.155, se = 0.046, es.type = "logit") # log-values
esc_d2or(d = -0.155, se = 0.046, es.type = "logit") # exponentiated
