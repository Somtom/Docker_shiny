# Function to match selected Calfnr and selected Eartag in Treatment Table
matchSelectedAnimalInfo <- function(input, session, rv) {
  
  # Treatment Table----
  # Match calves and eartags with feeder
  observeEvent(input$feederTreatment,{
    if (is.na(match(input$feederTreatment, rv$data$calves$feeder))) {
      choicesEartag <- c("", rv$data$calves$eartag)
      choicesCalf <- c("", rv$data$calves$calf.feeder)
    }
    else {
      choicesEartag <- c("", subset(rv$data$calves, feeder == input$feederTreatment)$eartag)
      choicesCalf <- c("", subset(rv$data$calves, feeder == input$feederTreatment)$calf.feeder)
      }
    
    updateSelectInput(session, inputId = "eartagTreatment", choices = choicesEartag)
    updateSelectInput(session, inputId = "calfTreatment", choices =  choicesCalf, selected = "")
  })
  
  # Match eartag for selected CalfNr
  observeEvent(input$calfTreatment,{
    if (is.na(match(input$calfTreatment, rv$data$calves$calf.feeder))) {
      selectedEartagTreatment <- ""
    }
    else {selectedEartagTreatment <- 
      rv$data$calves$eartag[match(input$calfTreatment, rv$data$calves$calf.feeder)]}
    
    updateSelectInput(session, inputId = "eartagTreatment", selected = selectedEartagTreatment)
  })
  
  # Match CalfNr for selected eartag
  observeEvent(input$eartagTreatment,{
    if (is.na(match(input$eartagTreatment, rv$data$calves$eartag)) | input$eartagTreatment == "") {
      selectedCalfTreatment <- ""
    }
    else {selectedCalfTreatment <-
      rv$data$calves$calf.feeder[match(input$eartagTreatment, rv$data$calves$eartag)]}

    updateSelectInput(session, inputId = "calfTreatment", selected = selectedCalfTreatment)
  })
  }