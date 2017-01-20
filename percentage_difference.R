# Determining effect size (h) from the difference between two percentages

c <- acos((2*(1-0.3)-1)) # control group proportion (30%)
t <- acos((2*(1-0.2)-1)) # treatment group proportion (20%)
h <- c-t
h

# or

h <- acos((2*(1-0.3)-1)) - acos((2*(1-0.2)-1))
round(h, 3)
