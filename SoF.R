## Calculate the corresponding risk for GRADE Summary of Findings tables
# See http://cccrg.cochrane.org/sites/cccrg.cochrane.org/files/public/uploads/Summary%20of%20Findings%20Tables.pdf (p.23)
# Data: Petrosino et al., 2013

# 1. Calculate the Assumed Risk
# i.e. risk in control group = n events / N
p <- 98 / 358
round(p*1000,0)

# 2. Convert the Odds Ratio to Risk Ratio
# RR = OR / (1 – p + (p x OR))
OR <- 1.68
RR <- OR / (1 - p * (1 - OR))
round(RR, 2)
# RR = 1.42

# 3. Repeat for OR confidence intervals
OR_lower <- 1.20
RR_lower <- OR_lower / (1 - p * (1 - OR_lower))
round(RR_lower, 2)
## CI (lower) = 1.14

OR_upper <- 2.36
RR_upper <- OR_upper / (1 - p * (1 - OR_upper))
round(RR_upper, 2)
## CI (upper) = 1.72

# 4. Multiply the RR by the Assumed Risk to obtain the Corresponding Risk
CR <- (RR * p)*1000
round(CR, 0)
# ie 39 per 1000

# 5. Repeat for confidence intervals
CR_lower <- (RR_lower * p)*1000
round(CR_lower, 0)
# ie 311 per 1000
CR_upper <- (RR_upper * p)*1000
round(CR_upper, 0)
# ie 471 per 1000
