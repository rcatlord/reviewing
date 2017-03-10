library(shiny)

# fields to be saved
fieldsAll <- c("reference",
               "inclusion",
               "country",
               "year",
               "context",
               "aim",
               "intervention",
               "assessment",
               "sample_size",
               "sample_selection",
               "findings",
               "conclusions")

# timestamp
humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")

# save the results to a file
saveData <- function(data) {
  fileName <- sprintf("%s_%s.csv",
                      humanTime(),
                      digest::digest(data))
  
  write.csv(x = data, file = file.path(responsesDir, fileName),
            row.names = FALSE, quote = TRUE)
}

# load all responses into a data.frame
loadData <- function() {
  files <- list.files(file.path(responsesDir), full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE)
  #data <- dplyr::rbind_all(data)
  data <- do.call(rbind, data)
  data
}

# directory where responses get stored
responsesDir <- file.path("/Users/henry/Documents/pro forma")

shinyApp(
  ui = fluidPage(
    h3("REA input tool", align = "center"),
    br(),
    fluidRow(
      column(5, offset = 1,
      textInput("ref", "Reference e.g. Smith & Jones (2012)"),
      checkboxInput("inclusion", "The study meets the inclusion criteria", FALSE),
      textInput("country", "Country of focus"),
      sliderInput("year", "Year of publication", min = 2000, max = 2016, value = 2000, sep=""),
      textInput("context", "Context of study"),
      textInput("aim", "Aim of the research")),
      tags$style(type='text/css', "#aim { height: 200px; }"),
      column(5,
      textInput("intervention", "Type of intervention"),
      radioButtons("assessment", "Quality assessment",
                  c("Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Systematic review", "Meta-analysis")),
      textInput("sample_size", "Sample size"),
      textInput("sample_selection", "Sample selection"),
      textInput("findings", "Findings"),
      textInput("conclusion", "Conclusions"),
      actionButton("submit", "Submit", class = "btn-primary")
      )
    )
  ),
  server = function(input, output, session) {
    
    # Gather all the form inputs (and add timestamp)
    formData <- reactive({
      data <- sapply(fieldsAll, function(x) input[[x]])
      data <- t(data)
      data
    }) 
    
    # action to take when submit button is pressed
    observeEvent(input$submit, {
      saveData(formData())
    })
  
  }
)
