# Convert standardised mean difference (d) to log odds ratio using Hasselblad and Hedges logit method
# Data source: Strang et al., (2013)

e1 <- esc_d2or(d = 0.137, se = 0.127, totaln = 249, es.type = "logit", study = "Sherman & Strang (2012) #2") # No.2
e2 <- esc_d2or(d = -0.044, se = 0.213, totaln = 106, es.type = "logit", study = "Shapland et al (2008) #4") # No.4
e3 <- esc_d2or(d = -0.105, se = 0.155, totaln = 186, es.type = "logit", study = "Shapland et al (2008) #5") # No.5
e4 <- esc_d2or(d = -0.144, se = 0.208, totaln = 103, es.type = "logit", study = "Shapland et al (2008) #6") # No.6
e5 <- esc_d2or(d = -0.201, se = 0.253, totaln = 105, es.type = "logit", study = "Shapland et al (2008) #9") # No.9
e6 <- esc_d2or(d = -0.200, se = 0.072, totaln = 782, es.type = "logit", study = "McGarrell & Hipple (2007) #3") # No.3
e7 <- esc_d2or(d = -0.247, se = 0.251, totaln = 63, es.type = "logit", study = "Shapland et al (2008) #7") # No.7
e8 <- esc_d2or(d = -0.276, se = 0.139, totaln = 165, es.type = "logit", study = "Shapland et al (2008) #8") # No.8
e9 <- esc_d2or(d = -0.279, se = 0.183, totaln = 121, es.type = "logit", study = "Sherman & Strang (2012) #1") # No.1
e10 <- esc_d2or(d = -0.333, se = 0.304, totaln = 105, es.type = "logit", study = "Shapland et al (2008) #10") # No.10
e_pooled <- esc_d2or(d = -0.155, se = 0.046, totaln = 1880, es.type = "logit", study = "Average Effect")

combined_e <- combine_esc(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10)
#combined_e$study <- reorder(combined_e$study, combined_e$es, FUN=mean)
combined_e <- rbind(combined_e, as.data.frame(e_pooled))

library(dplyr)
meta_data <- combined_e %>% rename(OR = es, lower = ci.lo, upper = ci.hi)
meta_data$shape <- ifelse(meta_data$study == "Average Effect", 23, 22)
meta_data$effect <- paste0(
  "<b>", meta_data$study, "</b>",
  "<br>", "OR ", round(meta_data$OR, 2), " [", round(meta_data$lower, 2), ", ", round(meta_data$upper, 2), "]",
  "</span></div>")

# forest theme
library(ggplot2)
forest_theme <- theme_minimal() +
  theme(plot.background = element_rect(fill = "gray97", color = NA),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(linetype = 3, size = 0.3, color = "gray50"),
        panel.border = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(vjust = 5, face = "bold", size = 18, colour = "#3C3C3C"),
        plot.subtitle = element_text(vjust = 5, size = 12, colour = "#3C3C3C"),
        axis.text.x = element_text(face = "bold", size = 11),
        axis.text.y = element_text(face = "bold", size = 11),
        axis.title.x = element_text(size = 11, colour = "#3C3C3C", face = "bold.italic", vjust = -0.5),
        legend.position = 'none',
        plot.margin = unit(c(1, 1, 0.5, 0.7), "cm"))
theme_set(forest_theme)

# static plot
library(scales)
ggplot(data = meta_data, aes(x = study, y = OR)) +
  geom_hline(aes(x = 0, yintercept = 1), lty = 1, size = 1.2, colour = "#535353") +
  geom_hline(aes(x = 0, yintercept = meta_data[meta_data$study == "Average Effect", ]$OR), lty = 2, size = 0.5, colour = "#535353") +
  geom_linerange(aes(ymin = lower, ymax = upper), size = 8, colour = "#ff662d") +
  geom_point(shape = meta_data$shape, size = 4, colour = "#ffffff", stroke = 1) +
  scale_y_continuous(trans =log_trans(), breaks = c(0.01,0.1,1,10,100)) +
  scale_x_discrete(limits = rev(levels(meta_data$study))) +
  labs(title = "Restorative justice conferencing",
       subtitle = "Odds Ratio (M-H, Random, 95% CI)",
       x = NULL, y = "Reduces reoffending   Increases reoffending",
       caption = "\nSource: Strang et al., (2013)") +
  coord_flip() +
  theme(axis.title.x = element_text(size = 12, colour = "#535353",
                                    face = "bold.italic",
                                    hjust = 0.96))
ggsave("forest_plot.png", scale = 1.2, dpi = 600)

# static plot (simplified)
g <- ggplot(data = meta_data, aes(x = study, y = OR, ymin = lower, ymax = upper)) +
  geom_hline(aes(x = 0, yintercept = 1), lty = 1, size = 1.2, colour = "#535353") +
  geom_hline(aes(x = 0, yintercept = meta_data[meta_data$study == "Average Effect", ]$OR), lty = 2, size = 0.5, colour = "#535353") +
  geom_linerange(size = 8, colour = "#ff662d") +
  geom_point(shape = meta_data$shape, size = 4, colour = "#ffffff", stroke = 1) +
  scale_y_continuous(trans =log_trans(), breaks = c(0.01,0.1,1,10,100)) +
  scale_x_discrete(limits = rev(levels(meta_data$study))) +
  labs(title = "Restorative justice conferencing",
       subtitle = "Odds Ratio (M-H, Random, 95% CI)",
       x = NULL, y = "Reduces reoffending Increases reoffending",
       caption = "\nSource: Strang et al., (2013)") +
  coord_flip() +
  theme(axis.title.x = element_text(size = 10, colour = "#535353", face = "bold.italic",
                                    hjust = 0.92)) + # adjust position of x-axis labels
  theme(axis.text.y = element_blank()) # remove y-axis labels

# interactive plot
library(ggiraph)
my_gg <- g + geom_point_interactive(aes(tooltip = effect, data_id = effect), shape = meta_data$shape, size = 2, colour = "#ff662d")
tooltip <- "background-color:white;color:#3C3C3C;font-family:Helvetica;padding:2px;border-radius:5px:"
ggiraph(code = print(my_gg), pointsize = 12, width = 0.7, tooltip_offx = 20, tooltip_offy = -10,
        hover_css = "cursor:pointer;fill:white;stroke:white;",
        tooltip_extra_css = tooltip)

# output as html
library(htmlwidgets)
g_interactive <- ggiraph(code = print(my_gg), pointsize = 12, width = 0.7, tooltip_offx = 20, tooltip_offy = -10,
                         hover_css = "cursor:pointer;fill:white;stroke:white;",
                         tooltip_extra_css = tooltip)
saveWidget(g_interactive, file="forest_plot_interactive.html")
