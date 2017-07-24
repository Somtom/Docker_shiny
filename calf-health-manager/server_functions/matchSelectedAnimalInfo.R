# Function to match selected Calfnr and selected Eartag in Treatment Table
matchSelectedAnimalInfo <- function(input, session, rv) {
  
  # Treatment Table----
  # Match calves and eartags with feeder
  observeEvent(input$feederTreatment,{
    if (is.na(match(input$feederTreatment, rv$data$calves$feeder))) {
      choicesEartag <- c("", rv$data$calves$eartag)
      choicesCalf <- c("",setNames(rv$data$calves$calfID,
                                   rv$data$calves$calf.feeder))
      updateSelectInput(session, inputId = "eartagTreatment", choices = choicesEartag)
      updateSelectInput(session, inputId = "calfTreatment", choices =  choicesCalf)
    }
    else {
      if (!(input$calfTreatment %in% subset(rv$data$calves, feeder == input$feederTreatment)$calfID)) {
        choicesEartag <- subset(rv$data$calves, feeder == input$feederTreatment)$eartag
        
        choicesCalf <- subset(rv$data$calves, feeder == input$feederTreatment)
        choicesCalf <- setNames(choicesCalf$calfID,
                                choicesCalf$calf.feeder)
        updateSelectInput(session, inputId = "eartagTreatment", choices = choicesEartag)
        updateSelectInput(session, inputId = "calfTreatment", choices =  choicesCalf)
        }
      }
  })
  
  # Match eartag and feeder for selected CalfNr
  observeEvent(input$calfTreatment,{
    if (is.na(match(input$calfTreatment, rv$data$calves$calfID))) {
      selectedEartagTreatment <- ""
      selectedFeederTreatment <- input$feederTreatment
    }
    else {
      selectedEartagTreatment <- 
        rv$data$calves$eartag[match(input$calfTreatment, rv$data$calves$calfID)]
      selectedFeederTreatment <- 
        rv$data$calves$feeder[match(input$calfTreatment, rv$data$calves$calfID)]
    }
    
    updateSelectInput(session, inputId = "eartagTreatment", selected = selectedEartagTreatment)  
    updateSelectInput(session, inputId = "feederTreatment", selected = selectedFeederTreatment)

  })
  
  # Match CalfNr for selected eartag
  observeEvent(input$eartagTreatment,{
    if (is.na(match(input$eartagTreatment, rv$data$calves$eartag)) | input$eartagTreatment == "") {
      selectedCalfTreatment <- ""
      selectedFeederTreatment <- input$feederTreatment
    }
    else {
      selectedCalfTreatment <-
        rv$data$calves$calfID[match(input$eartagTreatment, rv$data$calves$eartag)]
      selectedFeederTreatment <-
        rv$data$calves$feeder[match(input$eartagTreatment, rv$data$calves$eartag)]
      }

    updateSelectInput(session, inputId = "calfTreatment", selected = selectedCalfTreatment)
    updateSelectInput(session, inputId = "feederTreatment", selected = selectedFeederTreatment)
    
  })
  }