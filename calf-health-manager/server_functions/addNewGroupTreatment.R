addNewGroupTreatment <- function(input, output, session, rv, USER, couchIP) {
  
  observeEvent(input$button_ConfirmGroupTreatment, {
    # Check if crutial provided
    #if (input$purposeGroupTreatment == "") return(NULL)
    if (input$drugGroupTreatment == "") return(NULL)
    if (is.na(input$dosisGroupTreatment)) return(NULL)
    if (input$checkReminderGroupTreatment == TRUE) {
      if (is.na(input$nextGroupTreatment)) return(NULL)
    }
    
    print(rv$customCalfList)
    shinyjs::disable("button_ConfirmGroupTreatment")
    
    # Create data.frame with empty values
    newTreatment <- rv$customCalfList
    names(newTreatment) <- c("calf", "eartag", "feeder", "feedingDay")
    nCalves <- dim(newTreatment)[1]
    
    newTreatment <-
      data.frame(
        newTreatment,
        date = rep(as.character(input$dateTreatment), nCalves),
        type = rep("treatment", nCalves),
        findings = rep(NA, nCalves),
        diagnosis  = rep(NA, nCalves),
        temperature = rep(NA, nCalves),
        drug = rep(NA, nCalves),
        nextTreatment = rep(NA, nCalves),
        waitingTime = rep(NA, nCalves),
        AuANr = rep(NA, nCalves),
        actions = rep(NA, nCalves),
        observer = rep(NA, nCalves),
        user = USER$name,
        notes = rep(NA, nCalves)
      )
    
    # Assign input values to newTreatment table
    newTreatment$diagnosis <- rep(input$diagnosisGroupTreatment, nCalves)
    #newTreatment$purpose <- rep(input$purposeGroupTreatment, nCalves)
    newTreatment$notes <- rep(input$notesGroupTreatment, nCalves)
    newTreatment$drug <- rep(input$drugGroupTreatment, nCalves)
    newTreatment$waitingTime <- rep(input$waitingTimeGroupTreatment, nCalves)
    newTreatment$AuANr <- rep(input$AuANrGroupTreatment, nCalves)
    newTreatment$nextTreatment <- as.character(
      as.Date(Sys.time() + 86400*input$nextGroupTreatment))
    newTreatment$actions <- paste(ifelse(input$checkReminderGroupTreatment,
                                         rep("Erinnerung", nCalves),
                                         rep("", nCalves)),
                                  ifelse(input$checkGiveElectrolytGroup,
                                         rep(input$electrolytRecipieGroup, nCalves),
                                         rep("", nCalves)),
                                  ifelse(input$checkGiveMedicineGroup,
                                         rep(input$medicineRecipieGroup, nCalves),
                                         rep("", nCalves))
    )
    
    #write treatment into couchDB
    saveToCouchDB(newTreatment, serverName = couchIP)
    # add treatment to old table
    rv$treatmentTable <- rbind.fill(rv$treatmentTable, newTreatment)
    print("Debug: New group treatment saved")
    
    # set values to default for next Treatment
    shinyjs::reset("boxGroupTreatment")
    print("Debug: GroupTreatment values reset")
    
    # user information
    showshinyalert(session, "alertConfirmGroupTreatment", "Treatment successfully saved",
                   styleclass = "blank")
    
    shinyjs::enable("button_ConfirmGroupTreatment")
    
  })
}