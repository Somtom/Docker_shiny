shinyServer(function(input, output, session) {

  # Custom reactive Values
  rv <- reactiveValues()
  
  rv$treatmentTable <- treatmentTable
  
  
  inputCheckerTreatment <- function(input, output, session) {
    observeEvent(input$buttonConfirmTreatment, {
      
      output$inputCheckerTreatment <- renderText({
        validate(
          need(input$calfTreatment != "", "Please choose a calf"),
          need(input$eartagTreatment != "", "Please choose an eartag number"),
          need(input$diagnosisTreatment != "", "Please choose a diagnosis"),
          if (input$checkReminderTreatment == TRUE) {
            need(input$nextTreatment, "Please provide days until next treatment for reminder")
          },
          if (input$choiceDrugtreatment == TRUE) {
            need(input$drugTreatment != "", "Please choose a drug")
          }
        )
      }
      )
    })
  }
 
  inputCheckerTreatment(input, output, session)
  
  
  
  addNewTreatment <- function(input, output, session) {
    
    observeEvent(input$buttonConfirmTreatment, {
        # Check if crutial provided
        if (input$calfTreatment == "") return(NULL)
        if (input$eartagTreatment == "") return(NULL)
        if (input$diagnosisTreatment == "") return(NULL)
        if (input$checkReminderTreatment == TRUE) {
          if (is.na(input$nextTreatment)) return(NULL)
        }
        if (input$choiceDrugtreatment == TRUE) {
          if (input$drugTreatment == "") {return(NULL)}
        }
        
        # Create data.frame with empty values
        newTreatment <-
          data.frame(date = input$dateTreatment,
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
                     notes = input$notesTreatment)
        
        # Assign input values to newTreatment table
        newTreatment$calf <- input$calfTreatment
        newTreatment$eartag <- input$eartagTreatment
        newTreatment$user <- input$userTreatment
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
        
        
        # add treatment to old table
        rv$treatmentTable <- rbind(rv$treatmentTable, newTreatment)
        
        # user information
        showshinyalert(session, "alertConfirmTreatment", "Treatment successfully saved",
                       styleclass = "blank")
        print("Debug: New treatment saved")
        
        
        # set values to default for new Treatment
        updateSelectInput(session, inputId = "dateTreatment")
        updateSelectInput(session, inputId = "eartagTreatment", NA)
        #updateSelectInput(inputId = ,value = )
        print("Debug: Treatment values reset")
        
    })
  }
  
  addNewTreatment(input, output, session)
  
  # History Table
  # CustomTreatmentTable <- reactive({
  #   selectedColumns <- names(rv$treatmentTable) %in% c(input$checkHistoryTable,
  #                                                   "Datum", "Kalb", "Diagnose", "Art")
  #   rv$treatmentTable[selectedColumns]})
  
  output$historyTable <- 
    renderDataTable({rv$treatmentTable},
                    options = list(scrollX = TRUE)
                    )
  
  test <- "testname"
  output[[test]] <- renderText("Test output ok")
  
  
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


