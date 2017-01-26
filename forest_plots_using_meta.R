# meta package (Schwarzer, 2016)
library(meta)

# data derive from Campbell Collaboration systematic review of "Scared Straight" programmes (Petrosino et al., 2013)
df <- data.frame(
  study = c("Finkenauer", "GERPDC", "Lewis", "Michigan D.O.C.", "Orchowsky", "Vreeland", "Yarborough"),
  year = c(1982, 1979, 1983, 1967, 1981, 1981, 1979),
  event.e = c(19, 16, 43, 12, 16, 14, 27),
  n.e = c(46, 94, 53, 28, 39, 39, 137),
  event.c = c(4, 8, 37, 5, 16, 11, 17),
  n.c = c(35, 67, 55, 30, 41, 40, 90))

# odds ratio for binary outcomes from single study
metabin(event.e = 19, n.e = 46, event.c = 4, n.c = 35,
        sm = "OR",
        title = "Finkenauer (1982)")

# or
metabin(event.e, n.e, event.c, n.c, data = df,
        sm = "OR",
        subset = study=="Finkenauer",
        title = "Finkenauer (1982)")

# odds ratios for binary outcomes from multiple studies
m <- metabin(event.e, n.e, event.c, n.c, data = df,
             sm = "OR",
             studlab = paste(study, year),
             title = "Scared Straight")

# forest plot in RevMan 5 style
# library(grid)
png(filename="forest-plot.png", res=300, width=3000, height=1200)
forest(m,
       test.overall.fixed = TRUE,
       comb.random = FALSE, sortvar = TE,
       lab.e = "Treatment",
       leftlabs = c(NA, NA, NA, NA, NA),
       label.left = "Favours treatment", label.right = "Favours control", ff.lr = "italic",
       rightlabs = c("Weight", NA, NA),
       rightcols = c("w.fixed","effect", "ci"),
       col.diamond = "black", col.diamond.lines = "black",
       col.square = "darkblue", col.square.lines = "darkblue")
# grid.text("Effects of 'Scared Straight' programmes", .5, .75, gp = gpar(cex=1.2))
dev.off()

# simplified forest plot
png(filename="forest-plot_simplified.png", res=300, width=1300, height=1100)
forest(m,
       hetstat = FALSE,
       comb.random = FALSE, sortvar = TE,
       label.left = "Reduces crime", label.right = "Increases crime", ff.lr = "italic",
       col.diamond = "black", col.diamond.lines = "black",
       col.square = "darkblue", col.square.lines = "darkblue",
       leftcols="studlab", rightcols=FALSE)
dev.off()

# funnel plot for publication bias
funnel(m)
