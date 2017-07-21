addNewVaccination <- function(input, output, session, rv, USER, couchIP) {
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
    
    newVaccination <- 
      data.frame(
        newVaccination,
        date = rep(as.character(input$dateVaccination), nCalves),
        type = rep("vaccination", nCalves),
        purpose = rep(NA, nCalves),
        batchNr = rep(NA, nCalves),
        veterinary = rep(NA, nCalves),
        notesVaccination = rep(NA, nCalves),
        actions = rep(NA, nCalves),
        repeatVaccination = rep(NA, nCalves),
        user = rep(NA, nCalves)
      )
    
    # Assign input values to newVaccination table 
    newVaccination$purpose <- rep(input$vaccinationPurpose, nCalves)
    newVaccination$batchNr <- rep(input$batchNumberVaccination, nCalves)
    newVaccination$veterinary <- rep(input$vetVaccination, nCalves)
    newVaccination$notesVaccination <- rep(input$notesVaccination, nCalves)
    newVaccination$user <- USER$name
    newVaccination$actions <- rep(paste(ifelse(input$checkReminderVaccination,
                                               "Erinnerung",
                                               "")),
                                  nCalves)
    if (input$checkReminderVaccination) {
      newVaccination$repeatVaccination <- as.character(
        as.Date(Sys.time() + 86400*input$repeatVaccination))
    }

    #write vaccination into couchDB
    saveToCouchDB(newVaccination, serverName = couchIP)
    
    # add vaccination to old table
    rv$vaccinationTable <- rbind(rv$vaccinationTable, newVaccination)
    print("Debug: New Vaccination saved")
    
    # set values to default for next Vaccination
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