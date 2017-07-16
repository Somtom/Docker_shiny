# Function to match selected Calfnr and selected Eartag in Treatment Table
matchSelectedAnimalInfo <- function(input, session, data) {
  
  # Treatment Table----
  # Match eartag for selected CalfNr
  observeEvent(input$calfTreatment,{
    if(is.na(match(input$calfTreatment, data$calves$nr))){
      selectedEartagTreatment <- ""
    }
    else {selectedEartagTreatment <- 
      data$calves$eartag[match(input$calfTreatment, data$calves$nr)]}
    
    updateSelectInput(session, inputId = "eartagTreatment", selected = selectedEartagTreatment)
  })
  
  # Match CalfNr for selected eartag
  observeEvent(input$eartagTreatment,{
    if(is.na(match(input$eartagTreatment, data$calves$eartag))){
      selectedCalfTreatment <- ""
    }
    else {selectedCalfTreatment <- 
      data$calves$nr[match(input$eartagTreatment, data$calves$eartag)]}
    
    updateSelectInput(session, inputId = "calfTreatment", selected = selectedCalfTreatment)
  })
}