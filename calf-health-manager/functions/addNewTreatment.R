addNewTreatment <- function(input, output, session, rv, USER) {
  
  observeEvent(input$button_ConfirmTreatment, {
    # Check if crutial provided
    if (input$calfTreatment == "") return(NULL)
    if (input$eartagTreatment == "") return(NULL)
    if (input$findingsTreatment == "") return(NULL)
    if (input$checkReminderTreatment == TRUE) {
      if (is.na(input$nextTreatment)) return(NULL)
    }
    if (input$choiceDrugtreatment == TRUE) {
      if (input$drugTreatment == "") {return(NULL)}
    }
    
    shinyjs::disable("button_ConfirmTreatment")
    
    # Create data.frame with empty values
    newTreatment <-
      data.frame(date = input$dateTreatment,
                 type = "finding",
                 feeder = NA,
                 calf = NA,
                 eartag = NA,
                 findings = NA,
                 diagnosis  = NA,
                 temperature = NA,
                 drug = NA,
                 nextTreatment = NA,
                 waitingTime = NA,
                 AuANr = NA,
                 actions = NA,
                 observer = NA,
                 user = USER$name,
                 notes = input$notesTreatment)
    
    # Assign input values to newTreatment table
    newTreatment$calf <- input$calfTreatment
    newTreatment$eartag <- input$eartagTreatment
    newTreatment$observer <- input$observerTreatment
    newTreatment$findings <- input$findingsTreatment
    newTreatment$diagnosis <- input$diagnosisTreatment
    newTreatment$nextTreatment <- input$nextTreatment
    newTreatment$temperature <- input$temperatureTreatment
    if (input$choiceDrugtreatment == FALSE) {
      newTreatment$drug <- newTreatment$nextTreatment <- newTreatment$waitingTime <- newTreatment$AuANr <- NA
    }
    else {
      newTreatment$drug <- input$drugTreatment
      newTreatment$waitingTime <- input$waitingTimeTreatment
      newTreatment$AuANr <- input$AuANrTreatment
    }
    newTreatment$actions <- paste(ifelse(input$checkReminderTreatment, "Erinnerung", ""),
                                  ifelse(input$checkGiveElectrolyt, input$electrolytRecipie, ""),
                                  ifelse(input$checkGiveMedicine, input$medicineRecipie, "")
    )
    
    #write treatment into couchDB
    saveToCouchDB(newTreatment, serverName = "localhost")
    
    # add treatment to old table
    rv$treatmentTable <- rbind(rv$treatmentTable, newTreatment)
    print("Debug: New treatment saved")
    
    # set values to default for next Treatment
    shinyjs::reset("boxTreatment")
    print("Debug: Treatment values reset")
    
    # user information
    showshinyalert(session, "alertConfirmTreatment", "Treatment successfully saved",
                   styleclass = "blank")
    
    shinyjs::enable("button_ConfirmTreatment")
    
  })
}