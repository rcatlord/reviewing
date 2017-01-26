df <- data.frame(
  author = c("Finckenauer", "GERPDC", "Lewis", "Michigan D.O.C.", "Orchowsky", "Vreeland", "Yarborough"),
  year = c(1982, 1979, 1983, 1967, 1981, 1981, 1979),
  event.e = c(19, 16, 43, 12, 16, 14, 27),
  n.e = c(46, 94, 53, 28, 39, 39, 137),
  event.c = c(4, 8, 37, 5, 16, 11, 17),
  n.c = c(35, 67, 55, 30, 41, 40, 90))
df$study <- paste(df$author, df$year)

library(rmeta)
model.FE <- meta.MH(n.e, n.c, event.e, event.c, names = study, data = df)
meta_data <- as.data.frame(summary(model.FE)$stats)
pooled <- data.frame(study = "Average Effect",
                     OR = summary(model.FE)$MHci[2],
                     lower = summary(model.FE)$MHci[1],
                     upper = summary(model.FE)$MHci[3])

library(tibble) ; library(dplyr)
meta_data <- rownames_to_column(meta_data, var="study") %>%
  rename(lower = `(lower `, upper = `95% upper)`)
meta_data$study <- reorder(meta_data$study, meta_data$OR, FUN=mean)
meta_data <- rbind(meta_data, pooled)
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
ggplot(data = meta_data, aes(x = study, y = OR, ymin = lower, ymax = upper)) +
  geom_hline(aes(x = 0, yintercept = 1), lty = 1, size = 1.2, colour = "#535353") +
  geom_hline(aes(x = 0, yintercept = meta_data[meta_data$study == "Average Effect", ]$OR), lty = 2, size = 0.5, colour = "#535353") +
  geom_linerange(size = 8, colour = "#ff662d") +
  geom_point(shape = meta_data$shape, size = 4, colour = "#ffffff", stroke = 1) +
  scale_y_continuous(trans =log_trans(), breaks = c(0.01,0.1,1,10,100)) +
  scale_x_discrete(limits = rev(levels(meta_data$study))) +
  labs(title = "'Scared Straight' programmes",
       subtitle = "Odds Ratio (M-H, Fixed, 95% CI)",
       x = NULL, y = "Reduces reoffending   Increases reoffending",
       caption = "\nSource: Petrosino et al., (2013)") +
  coord_flip() +
  theme(axis.title.x = element_text(size = 12, colour = "#535353",
                                    face = "bold.italic",
                                    hjust = -0.22))
ggsave("forest_plot.png", scale = 1.2, dpi = 600)

# static plot (simplified)
g <- ggplot(data = meta_data, aes(x = study, y = OR, ymin = lower, ymax = upper)) +
  geom_hline(aes(x = 0, yintercept = 1), lty = 1, size = 1.2, colour = "#535353") +
  geom_hline(aes(x = 0, yintercept = meta_data[meta_data$study == "Average Effect", ]$OR), lty = 2, size = 0.5, colour = "#535353") +
  geom_linerange(size = 8, colour = "#ff662d") +
  geom_point(shape = meta_data$shape, size = 4, colour = "#ffffff", stroke = 1) +
  scale_y_continuous(trans =log_trans(), breaks = c(0.01,0.1,1,10,100)) +
  scale_x_discrete(limits = rev(levels(meta_data$study))) +
  labs(title = "'Scared Straight' programmes",
       subtitle = "Odds Ratio (M-H, Fixed, 95% CI)",
       x = NULL, y = "Reduces reoffending Increases reoffending",
       caption = "\nSource: Petrosino et al., (2013)") +
  coord_flip() +
  theme(axis.title.x = element_text(size = 10, colour = "#535353", face = "bold.italic",
                                    hjust = -0.05)) + # adjust position of x-axis labels
  theme(axis.text.y = element_blank()) # remove y-axis labels
g

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

# static plot with horizontal errorbars and faceting
meta_data$facet <- ifelse(meta_data$study == "Average Effect", "Summary", "Individual")
meta_data$facet <- factor(meta_data$facet, c('Individual', 'Summary'))
ggplot(data = meta_data, aes(x = OR, y = study, xmin = lower, xmax = upper)) +
  geom_vline(aes(x = 0, xintercept = 1), lty = 1, size = 1.2, colour = "#535353") +
  geom_vline(aes(x = 0, xintercept = meta_data[meta_data$study == "Average Effect", ]$OR), lty = 2, size = 0.5, colour = "#535353") +
  geom_errorbarh(height = 0.2, colour = "#ff662d") +
  geom_point(shape = meta_data$shape, size = 4, fill = "#ff662d", colour = "#ff662d", stroke = 1) +
  scale_x_continuous(trans = log_trans(), breaks = c(0.01,0.1,1,10,100)) +
  labs(title = "'Scared Straight' programmes",
       subtitle = "Odds Ratio (M-H, Fixed, 95% CI)",
       x = NULL, y = NULL,
       caption = "\nSource: Petrosino et al., (2013)") +
  facet_grid(facet ~ ., scales = "free", space = "free") +
  theme(strip.text = element_blank())
