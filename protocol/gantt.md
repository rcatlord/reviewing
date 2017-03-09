```r
library(DiagrammeR) ; library(tidyr) ; library(dplyr)

# simple
gantt <- mermaid("
gantt
                 dateFormat  YYYY-MM-DD
                 title Provisional timeline for Rapid Evidence Assessment
                 
                 section Stage
                 Develop protocol                        :    review_1, 2017-02-13, 3d
                 Peer review protocol                    :    review_2, after review_1, 2d
                 Search for studies                      :    review_3, 2017-02-20, 1d 
                 Study selection                         :    review_4, 2017-02-21, 21d 
                 Data extraction                         :    review_5, after review_4, 7d 
                 Assessment of methodological quality    :    review_6, after review_5, 3d 
                 Synthesis                               :    review_7, after review_6, 2d 
                 Prepare draft REA                       :    review_8, after review_7, 8d
                 Publish REA                             :    review_9, after review_8, 8d
                 ")
gantt

gantt$x$config = list(ganttConfig = list(
  axisFormatter = list(list(
    "%d-%b"
    ,htmlwidgets::JS(
      'function(d){ return d.getDay() == 1 }'
    )
  ))
))

gantt
```
