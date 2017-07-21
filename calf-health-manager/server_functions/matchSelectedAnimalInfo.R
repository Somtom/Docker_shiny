# Function to match selected Calfnr and selected Eartag in Treatment Table
matchSelectedAnimalInfo <- function(input, session, rv) {
  
  # Treatment Table----
  # Match calves and eartags with feeder
  observeEvent(input$feederTreatment,{
    if (is.na(match(input$feederTreatment, rv$data$calves$feeder))) {
      choicesEartag <- rv$data$calves$eartag
      choicesCalf <- rv$data$calves$nr
    }
    else {
      choicesEartag <- subset(rv$data$calves, feeder == input$feederTreatment)$eartag
      choicesCalf <- subset(rv$data$calves, feeder == input$feederTreatment)$nr
      }
    
    updateSelectInput(session, inputId = "eartagTreatment", choices = choicesEartag)
    updateSelectInput(session, inputId = "calfTreatment", choices =  choicesCalf)
  })
  
  # Match eartag for selected CalfNr
  observeEvent(input$calfTreatment,{
    if (is.na(match(input$calfTreatment, rv$data$calves$nr))) {
      selectedEartagTreatment <- ""
    }
    else {selectedEartagTreatment <- 
      rv$data$calves$eartag[match(input$calfTreatment, rv$data$calves$nr)]}
    
    updateSelectInput(session, inputId = "eartagTreatment", selected = selectedEartagTreatment)
  })
  
  # Match CalfNr for selected eartag
  observeEvent(input$eartagTreatment,{
    if (is.na(match(input$eartagTreatment, rv$data$calves$eartag))) {
      selectedCalfTreatment <- ""
    }
    else {selectedCalfTreatment <-
      rv$data$calves$nr[match(input$eartagTreatment, rv$data$calves$eartag)]}

    updateSelectInput(session, inputId = "calfTreatment", selected = selectedCalfTreatment)
  })
}