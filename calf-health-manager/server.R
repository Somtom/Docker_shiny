shinyServer(function(input, output, session) {

  # Custom reactive Values
  rv <- reactiveValues()
  
  rv$treatmentTable <- treatmentTable
  
  
  # Add treatment
  observeEvent(input$buttonConfirmTreatment, {

    output$textConfirmTreatment <- renderText({
      validate(
        need(input$calf != "", "Please choose a calf"),
        need(input$eartag != "", "Please choose an eartag number"),
        need(input$diagnosis != "", "Please choose a diagnosis"),
        if (input$checkReminder == TRUE) {
          need(input$nextTreatment, "Please provide days until next treatment for reminder")
        },
        if (input$drugtreatment == TRUE) {
          need(input$drug != "", "Please choose a drug")
        }
      )
      }
    )
  })
  
  observeEvent(input$buttonConfirmTreatment, {
    
    
    if (input$calf == "") return(NULL)
    if (input$eartag == "") return(NULL)
    if (input$diagnosis == "") return(NULL)
    if (input$checkReminder == TRUE) {
      if (is.na(input$nextTreatment)) return(NULL)
    }
    if (input$drugtreatment == TRUE) {
      if (input$drug == "") {return(NULL)}
    }
    
    # Create data.frame with empty values
    newTreatment <-
      data.frame(date = as.Date(Sys.time()),
                 type = "Befund",
                 calf = NA,
                 eartag = NA,
                 diagnosis  = NA,
                 temperature = NA,
                 drug = NA,
                 nextTreatment = NA,
                 waitingTime = NA,
                 AuANr = NA,
                 actions = NA,
                 user = NA,
                 notes = input$notes)
    
    # Assign input values to newTreatment table
    newTreatment$calf <- input$calf
    newTreatment$eartag <- input$eartag
    newTreatment$user <- input$user
    newTreatment$diagnosis <- input$diagnosis
    newTreatment$nextTreatment <- input$nextTreatment
    newTreatment$temperature <- input$temperature
    if (input$drugtreatment == FALSE) {
      newTreatment$drug <- newTreatment$nextTreatment <- newTreatment$waitingTime <- newTreatment$AuANr <- NA
    }
    else {
      newTreatment$drug <- input$drug
      newTreatment$waitingTime <- input$waitingTime
      newTreatment$AuANr <- input$AuANr
    }
    
    rv$treatmentTable <- rbind(rv$treatmentTable, newTreatment)
    print("Debug: Treatment saved")
  })
  
  # History Table
  # CustomTreatmentTable <- reactive({
  #   selectedColumns <- names(rv$treatmentTable) %in% c(input$checkHistoryTable,
  #                                                   "Datum", "Kalb", "Diagnose", "Art")
  #   rv$treatmentTable[selectedColumns]})
  
  output$historyTable <- 
    renderDataTable({rv$treatmentTable},
                    options = list(scrollX = TRUE)
                    )
  
  # Dashboard Link Boxes ----------------------------------------------------    
  # Treatment Link Box
  output$goToTreatment <- renderValueBox({
    box1 <- valueBox(value = "Befund",
                   icon = icon("thermometer-full"),
                   width = NULL,
                   color = "red",
                   href = "#",
                   subtitle = "Befund oder Behandlung eintragen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToTreatment"
    return(box1)
  })
  
  # Switch: Dashboard to Treatment
  observeEvent(input$button_goToTreatment, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "treatment"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # Vaccination Link Box
  output$goToVaccination <- renderValueBox({
    box1<-valueBox(value = "Impfung",
                   icon = icon("medkit"),
                   width = NULL,
                   color = "yellow",
                   href = "#",
                   subtitle = "Impfung eintragen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToVaccination"
    return(box1)
  })
  
  # Switch: Dashboard to Vaccination
  observeEvent(input$button_goToVaccination, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "vaccination"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # History Link Box
  output$goToHistory <- renderValueBox({
    box1<-valueBox(value = "History",
                   icon = icon("book"),
                   width = NULL,
                   color = "aqua",
                   href = "#",
                   subtitle = "Historie ansehen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToHistory"
    return(box1)
  })
  
  # Switch: Dashboard to History
  observeEvent(input$button_goToHistory, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "history"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
   
  # Settings Link Box
  output$goToSettings <- renderValueBox({
    box1<-valueBox(value = "Optionen",
                   icon = icon("gear"),
                   width = NULL,
                   color = "light-blue",
                   href = "#",
                   subtitle = "Eingabemasken anpassen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToSettings"
    return(box1)
  })
  
  # Switch: Dashboard to Settings
  observeEvent(input$button_goToSettings, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "settings"
    )
    updateTabItems(session, "menuTabs", newtab)
  })





  

  

  
  
  # Debug -------------------------------------------------------------------

  
})


