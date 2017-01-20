# Convert Odds Ratio to Risk Ratio

# RR = OR / (1 – p + (p x OR))
# where p = the risk in the control group (i.e. n events / N)
OR <- 1.68
p <- 98 / 358
RR <- OR / (1 - p + (p * OR))
round(RR, 2)
