addNewTreatment <- function(input, output, session, rv, USER, couchIP) {

  observeEvent(input$button_ConfirmTreatment, {
    # Check if crutial provided
    if (input$calfTreatment == "") return(NULL)
    #if (input$eartagTreatment == "") return(NULL)
    if (input$feederTreatment == "") return(NULL)
    if (paste(input$findingsTreatment, collapse = ",") == "") return(NULL)
    if (input$checkReminderTreatment == TRUE) {
      if (is.na(input$nextTreatment)) return(NULL)
    }
    if (input$choiceDrugtreatment == TRUE) {
      if (input$drugTreatment == "") {return(NULL)}
    }
    
    shinyjs::disable("button_ConfirmTreatment")
    
    # Create data.frame with empty values
    newTreatment <-
      data.frame(date = as.character(input$dateTreatment),
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
                 users = NA,
                 notes = input$notesTreatment,
                 feedingDay = NA,
                 calfID = NA)
    
    # Assign input values to newTreatment table
    newTreatment$feeder <- input$feederTreatment
    newTreatment$calf <- rv$data$calves$nr[with(rv$data$calves,match(input$calfTreatment, calfID))]
    newTreatment$calfID <- input$calfTreatment
    ####
    newTreatment$users <- I(subset(rv$data$calves, calfID == input$calfTreatment)$users)
    ####
    newTreatment$eartag <- input$eartagTreatment
    newTreatment$observer <- input$observerTreatment
    # convert vector to string if multiple findings
    newTreatment$findings <- paste(input$findingsTreatment, collapse = ", ")
    newTreatment$diagnosis <- input$diagnosisTreatment
    newTreatment$temperature <- input$temperatureTreatment
    newTreatment$feedingDay <- subset(rv$data$calves,
                                      calfID == input$calfTreatment)$feedingDay
    if (input$choiceDrugtreatment == FALSE) {
      newTreatment$drug <- newTreatment$nextTreatment <- newTreatment$waitingTime <- newTreatment$AuANr <- NA
    }
    else {
      newTreatment$drug <- input$drugTreatment
      newTreatment$waitingTime <- input$waitingTimeTreatment
      newTreatment$AuANr <- input$AuANrTreatment
      newTreatment$type <- paste(newTreatment$type,", treatment")
      newTreatment$nextTreatment <- as.character(
        as.Date(Sys.time() + 86400*input$nextTreatment))
    }
    newTreatment$actions <- paste(ifelse(input$checkReminderTreatment, "Erinnerung", ""),
                                  ifelse(input$checkGiveElectrolyt, input$electrolytRecipie, ""),
                                  ifelse(input$checkGiveMedicine, input$medicineRecipie, "")
    )
    
    #write treatment into couchDB
    saveToCouchDB(newTreatment, serverName = couchIP)
    # add treatment to old table
    if (is.null(rv$treatmentTable)) {rv$treatmentTable <- newTreatment} # if no treatments available
    else {rv$treatmentTable <- rbind.fill(rv$treatmentTable, newTreatment)}
    print("Debug: New treatment saved")
    
    # set values to default for next Treatment
    shinyjs::reset("boxTreatment")
    print("Debug: Treatment values reset")
    
    newtab <- switch(input$menuTabs,
                     "treatment" = "dashboard"
    )
    updateTabItems(session, "menuTabs", newtab)
    
    # user information
    showshinyalert(session, "alertConfirm", "Treatment successfully saved",
                   styleclass = "blank")
    
    shinyjs::enable("button_ConfirmTreatment")
    
  })
}