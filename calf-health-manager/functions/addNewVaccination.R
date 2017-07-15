addNewVaccination <- function(input, output, session, rv, USER) {
  observeEvent(input$button_ConfirmVaccination, {
    # Check if crutial provided
    if (input$vaccinationPurpose == "") return(NULL)
    if (input$vaccine == "") return(NULL)
    if (input$checkReminderVaccination == TRUE) {
      if (is.na(input$repeatVaccination)) return(NULL)
    }
    shinyjs::disable("button_ConfirmVaccination")
    
    # Create data.frame with empty values
    newVaccination <- rv$customCalfList
    names(newVaccination) <- c("calf", "eartag", "feeder", "feedingDay")
    nCalves <- dim(newVaccination)[1]
    
    newVaccination$date <- rep(input$dateVaccination, nCalves) 
    newVaccination$type <- rep("vaccination", nCalves)
    newVaccination$purpose <- rep(input$vaccinationPurpose, nCalves)
    newVaccination$batchNr <- rep(input$batchNumberVaccination, nCalves)
    newVaccination$veterinary <- rep(input$vetVaccination, nCalves)
    newVaccination$notesVaccination <- rep(input$notesVaccination, nCalves)
    newVaccination$actions <- rep(paste(ifelse(input$checkReminderTreatment,
                                               "Erinnerung",
                                               "")),
                                  nCalves)
    newVaccination$user <- USER$name
    
    #write vaccination into couchDB
    saveToCouchDB(newVaccination, serverName = "localhost")
    
    # add vaccination to old table
    rv$vaccinationTable <- rbind(rv$vaccinationTable, newVaccination)
    print("Debug: New Vaccination saved")
    
    # set values to default for next Treatment
    shinyjs::reset("boxVaccination")
    print("Debug: Vaccination values reset")
    

    
    # hide dynamic UI
    shinyjs::hide(id = "dynamicVaccinationUI")
    shinyjs::show(id = "selectCalvesInfoVaccination")
    
    newtab <- switch(input$menuTabs,
                     "vaccination" = "dashboard"
    )
    updateTabItems(session, "menuTabs", newtab)
    
    # user information
    showshinyalert(session, "alertConfirmVaccination", "Vaccination successfully saved",
                   styleclass = "blank")
    
    shinyjs::enable("button_ConfirmVaccination")
  })

}