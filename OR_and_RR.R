# Study: Finckenauer (1982)
# Methods: Random assignment
# Participants: 81 children and young adults aged 11-18 years of which 50% had previously offended
# Intervention: 3 hour rap session with ‘Lifers’ in Rahway State Prison in New Jersey
# Outcome: Percentage of new complaints, contacts or court appearances after 6 month follow-up period

# Number of participants who committed new offences 6 months after the intervention: a
a <- 19
# Number of participants who committed new offences 6 months after 'business as usual': b
b <- 4
# Number of participants who did not commit new offences 6 months after the intervention: c
c <- 27
# Number of participants who did not commit new offences 6 months after 'business as usual': d
d <- 31
# Total sample
a+c+b+d
# Total for the intervention: a+c
a+c
# Total for 'business as usual': b+d
b+d

# Therefore:

# Percentage of the treatment group that committed new offences: a/(a+c)*100
round(a/(a+c)*100,2)
# Percentage of the control group that committed new offences: b/(b+d)*100
round(b/(b+d)*100,2)

# Odds of the outcome in the treatment group: a/c
round(a/c, 2)
# Odds of the outcome in the control group: b/d
round(b/d, 2)
# Odds ratio for the outcome comparing treatment with control: (a/c)/(b/d)
round((a/c)/(b/d), 2)

# Risk of the outcome in the treatment group: a/(a+c)
round(a/(a+c), 2)
# Risk of the outcome in the control group: b/(b+d)
round(b/(b+d),2)
# Relative risk comparing treatment with control: (a×(b+d))/(b×(a+c))
round((a*(b+d))/(b*(a+c)),2)
